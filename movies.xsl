<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:my="http://example.com/my-functions"
    version="2.0">
    <xsl:output method="html" indent="yes" />

    <!-- allows us to eliminate duplicates in our list -->
    <xsl:key name="movieKey" match="movie" use="title" />

    <xsl:template match="/">
        <xsl:variable name="time_at_run"
            select="format-dateTime(current-dateTime(), '[D01] [MNn] [Y0001] [h01]:[m01] [P]')" />
        <html>
            <head>
                <title>Joseph's Movie Database</title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
                <link rel="stylesheet" type="text/css" href="styles.css"></link>
                <script src="movies.js" defer=""></script>
                <script src="script.js" defer=""></script>
            </head>

            <body>
                <nav>
                    <a href="#home">Home</a>
                    <a href="#movies">Movies</a>
                    <a href="#about">About</a>
                    <a href="#contact">Contact</a>

                </nav>
                <div class="titlebar">
                    <h2>Movies</h2>
                    <button id="hello-button">Do Not Click Me</button>

                    <h5> Date Last Updated: <xsl:value-of
                            select="$time_at_run" />
                    </h5>
                    <!-- <img id="marque" src="images/DB_Marque.png" alt="Movie Database Marque" /> -->
                </div>

                <div class="MovieContainer">
                    <xsl:for-each select="//movie[not(title = preceding-sibling::movie/title)]">
                        <xsl:sort select="title" order="ascending" />
                        <div class="Movie"
                            id="Movie-{position() - 1}">
                            <ul>
                                <li class="title"> Title: <xsl:value-of select="title" /></li>
                                <li class="Director"> Author: <xsl:value-of select="director" /></li>
                                <xsl:choose>
                                    <xsl:when test="year &lt; 1950">
                                        <li class="release-year-classic"> Release Year (Classic): <xsl:value-of
                                                select="year" /></li>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <li class="release-year"> Release Year: <xsl:value-of
                                                select="year" /></li>
                                    </xsl:otherwise>
                                </xsl:choose>

                                <xsl:copy-of select="my:tagGenre(genre)" />

                                <li class="plot"> Plot: <span class="plot-text"></span></li>


                                <!-- Pulls data from a seperate file in the same DIR to be used for
                                the plot. Is related by position in the file. movies 0 = plot 0  -->
                            </ul>
                        </div>

                    </xsl:for-each>
                </div>
                <footer>
                    <p> Copyright 2025 Joseph Robles</p>
                </footer>
            </body>
            
        </html>
    </xsl:template>

    <xsl:function name="my:tagGenre" as="element(li)">
        <xsl:param name="genre" as="xs:string" />
        <xsl:variable name="li-element">
            <xsl:choose>
                <xsl:when test="$genre = 'Sci-Fi'">
                    <li class="genre-sci-fi">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:when>
                <xsl:when test="$genre = 'Drama'">
                    <li class="genre-drama">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:when>
                <xsl:when test="$genre = 'Thriller'">
                    <li class="genre-thriller">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:when>
                <xsl:when test="$genre = 'Adventure'">
                    <li class="genre-adventure">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:when>
                <xsl:when test="$genre = 'Crime'">
                    <li class="genre-crime">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:when>
                <xsl:when test="$genre = 'War'">
                    <li class="genre-war">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:when>
                <xsl:when test="$genre = 'Fantasy'">
                    <li class="genre-fantasy">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:when>
                <xsl:when test="$genre = 'Horror'">
                    <li class="genre-horror">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:when>
                <xsl:when test="$genre = 'Comedy'">
                    <li class="genre-comedy">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:when>
                <xsl:when test="$genre = 'Documentary'">
                    <li class="genre-documentary">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:when>
                <xsl:otherwise>
                    <li class="genre">Genre: <xsl:value-of select="$genre" /></li>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:copy-of
            select="$li-element/*" />
    </xsl:function>

</xsl:stylesheet>
# twp_case_king

A two week project for CS222. This project will take a website URL from wikipedia and find the last
five users who made a change to the page and input them a page.

Our program should solve the following:
    1. See who most recently changed a Wikipedia article so that I can include that information 
in my article.
    2. When I provide the name of a Wikipedia article, the system responds by giving me the
username of the person who most recently changed the article.
    3. Inform me if I was redirected as part of a search, including the name of the page to which 
I was redirected. For example, a search for “Biden” redirects to “Joe Biden,” so the result could 
start with the line “Redirected to Joe Biden”.
    3. Let me know if there is no such Wikipedia page for the search term.
    4. Notify me if there is a network error that prevents current access to Wikipedia.
    5. During the Wikipedia query, interaction with the application is disabled. For example, I 
cannot type a new article name while the previous request is being processed.
    6. The system responds with the username and timestamp of the most recent thirty edits.
    7. Times are given in ISO 8601 format in UTC.
    8. If there are fewer than thirty changes in the history of the page, show all the changes.
    9. Handle redirects, errors, and other conditions as above.

Author 1: David Case
Author 2: Jake King
## Getting Started


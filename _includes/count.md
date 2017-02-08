{% assign countries = site.data.countries %}
{% assign countries_size = countries.size | times: 1.0 %}

{% assign visited_country_count = 0 %}
{% for country in countries %}
  {% if country.visited > 0 %}
    {% assign visited_country_count = visited_country_count | plus:1 %}
  {% endif %}
{% endfor %}

visited countries: {{ visited_country_count }}<br>
countries left for provisional TCC membership: {{ 75 | minus:visited_country_count }}<br>
countries left for full TCC membership: {{ 100 | minus:visited_country_count }}<br>
percentage of countries visited: {{ visited_country_count | times:100 | divided_by:countries_size | round: 2}} %<br>

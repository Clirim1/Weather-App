class City {
  final String name;
  final String country;
  final double lat;
  final double lon;

  City({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    final code = json['country'];
    final countryName = _countryNames[code] ?? code;
    return City(
      name: json['name'],
      country: countryName,
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "country": country, "lat": lat, "lon": lon};
  }
}

const Map<String, String> _countryNames = {
  "AL": "Albania",
  "AD": "Andorra",
  "AT": "Austria",
  "BY": "Belarus",
  "BE": "Belgium",
  "BA": "Bosnia and Herzegovina",
  "BG": "Bulgaria",
  "HR": "Croatia",
  "CY": "Cyprus",
  "CZ": "Czech Republic",
  "DK": "Denmark",
  "EE": "Estonia",
  "FI": "Finland",
  "FR": "France",
  "DE": "Germany",
  "GR": "Greece",
  "HU": "Hungary",
  "IS": "Iceland",
  "IE": "Ireland",
  "IT": "Italy",
  "XK": "Kosovo",
  "LV": "Latvia",
  "LI": "Liechtenstein",
  "LT": "Lithuania",
  "LU": "Luxembourg",
  "MT": "Malta",
  "MD": "Moldova",
  "MC": "Monaco",
  "ME": "Montenegro",
  "NL": "Netherlands",
  "MK": "North Macedonia",
  "NO": "Norway",
  "PL": "Poland",
  "PT": "Portugal",
  "RO": "Romania",
  "RU": "Russia",
  "SM": "San Marino",
  "RS": "Serbia",
  "SK": "Slovakia",
  "SI": "Slovenia",
  "ES": "Spain",
  "SE": "Sweden",
  "CH": "Switzerland",
  "TR": "Turkey",
  "UA": "Ukraine",
  "GB": "United Kingdom",
  "US": "United States",
  "CA": "Canada",
  "MX": "Mexico",
  "BR": "Brazil",
  "AR": "Argentina",
  "CL": "Chile",
  "AU": "Australia",
  "NZ": "New Zealand",
  "JP": "Japan",
  "CN": "China",
  "IN": "India",
  "SG": "Singapore",
  "KR": "South Korea",
  "ZA": "South Africa",
  "EG": "Egypt",
  "AE": "United Arab Emirates",
  "SA": "Saudi Arabia",
};

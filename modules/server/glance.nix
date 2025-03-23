{ config, pkgs, lib, ... }:

with lib;
{
  options.homelab.glance = mkEnableOption "Enable Glance";
  config = mkIf config.homelab.glance {
    services.glance = {
      enable = true;
      package = pkgs.unstable.glance;
      settings = {
        server.port = 5050;
        pages = [
          {
            name = "home";
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "calendar";
                    first-day-of-week = "monday";
                  }
                  {
                    type = "rss";
                    title = "News";
                    limit = 10;
                    collapse-after = 5;
                    cache = "24h";
                    feeds = [
                      {
                        url = "https://www.theguardian.com/uk/rss";
                        title = "The Guardian";
                      }
                      {
                        url = "https://feeds.nos.nl/nosnieuwsbinnenland";
                        title = "NOS";
                      }
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "search";
                    search-engine = "https://www.startpage.com/sp/search?query={QUERY}";
                    bangs = [
                      {
                        title = "YouTube";
                        shortcut = "!yt";
                        url = "https://www.youtube.com/results?search_query={QUERY}";
                      }
                    ];
                  }
                  {
                    type = "hacker-news";
                  }
                  {
                    type = "videos";
                    channels = [
                      "UCXuqSBlHAE6Xw-yeJA0Tunw"
                      "UCsBjURrPoezykLs9EqgamOA"
                      "UCUyeluBRhGPCW4rPe_UvBZQ"
                      "UC68TLK0mAEzUyHx5x5k-S1Q"
                    ];
                  }
                  {
                    type = "group";
                    widgets = [
                      {
                        type = "rss";
                        title = "c/Linux";
                        limit = 20;
                        collapse-after = 5;
                        cache = "12h";
                        feeds = [
                          {
                            url = "https://lemmy.ml/feeds/c/linux.xml?sort=Hot";
                            title = "lemmy.ml";
                          }
                        ];
                      }
                      {
                        type = "rss";
                        title = "c/Android";
                        limit = 20;
                        collapse-after = 5;
                        cache = "12h";
                        feeds = [
                          {
                            url = "https://lemdro.id/feeds/c/android.xml?sort=Hot";
                            title = "lemdro.id";
                          }
                        ];
                      }
                      {
                        type = "rss";
                        title = "c/Technology";
                        limit = 20;
                        collapse-after = 5;
                        cache = "12h";
                        feeds = [
                          {
                            url = "https://beehaw.org/feeds/c/technology.xml?sort=Hot";
                            title = "beehaw.org";
                          }
                        ];
                      }
                    ];
                  }
                ];
              }
              {
                size = "small";
                widgets = [
                  {
                    type = "markets";
                    title = "Indices";
                    markets = [
                      {
                        symbol = "DX-Y.NYB";
                        name = "Dollar Index";
                      }
                      {
                        symbol = "^XDE";
                        name = "Euro Index";
                      }
                    ];
                  }
                  {
                    type = "markets";
                    title = "Crypto";
                    markets = [
                      {
                        symbol = "BTC-USD";
                        name = "Bitcoin";
                      }
                      {
                        symbol = "ETH-USD";
                        name = "Ethereum";
                      }
                    ];
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}

require 'mechanize'

module Importers
  class WhoSampled

    def self.track(url)
      agent = Mechanize.new
      page = agent.get(url)

      track = Track.find_or_create_by(title: page.search('div.trackInfo h1[itemprop=name]').text,
                                      release_date: page.search('div.trackInfo span[itemprop=datePublished]').text)

      artist = Artist.find_or_create_by(name: page.search('div.trackArtists h2 a').text)

      title = page.search('div.trackReleaseDetails h3.release-name a').text
      album = Album.find_or_create_by(title: title.blank? ? "Single - #{artist.name}" : title)

      track.albums << album
      album.artists << artist

      page.search('.section + section a.playIcon').each do |sample_link|
        compare_page = Mechanize::Page::Link.new(sample_link, agent, page).click
        sample_page = compare_page.links_with(class: 'trackName').last.click

        sample = Track.find_or_create_by(title: sample_page.search('div.trackInfo h1[itemprop=name]').text,
                                         release_date: sample_page.search('div.trackInfo span[itemprop=datePublished]').text)

        artist = Artist.find_or_create_by(name: sample_page.search('div.trackArtists h2 a').text)

        title = sample_page.search('div.trackReleaseDetails h3.release-name a').text
        album = Album.find_or_create_by(title: title.blank? ? "Single - #{artist.name}" : title)

        track.samples << sample
        sample.albums << album
        album.artists << artist
      end
    end
  end
end

# Media Playout: Media Playlists

A ruby library for generating the minimal XML required for a media playlist for use in testing products based on the BBC Media Player.

## Creation

The MediaPlayer constructor takes a block with which can you add media items to the collection:

    require 'media_playlist_generator'
    
    media_playlist = BBC::MediaPlaylist.new do |playlist|
      playlist << playlist_item_one 
      playlist << playlist_item_two
    end

### Playlist Items    

The `playlist_item` is a collection of data attributes that correspond to either a programme identifier to be used with MediaSelector or a media connection that itself can hold a collection of CDN end points.
Currently the playlist item can be in the form of a Hash or an OpenStruct.

Currently becuase of an issue with the Media Player all playlist items have to declare one of default AV types: programme, ident, advert, radioProgramme

Futher information on playlists can be found on the [BBC Future Media's Confluence page](https://confluence.dev.bbc.co.uk/display/emp/Playlist)

#### Mediation Items

Playlist items intended to represent mediation points should have a `:pid` key
    
    { type: 'programme', pid: 'a-pid' }
    
#### Media Items

Playlist items intended to represent media connections should have a key `:connections` method which contains a collection of 'connections' that each have a key `:href`:
    
    playlist_item = { type: 'programme', connections: [{ href: 'http://www.example.com/path/to/media/file' }])
    
## Serialization


To serialize the media playlist into an xml format use the playlist xml serializer:

    media_playlist.to_xml
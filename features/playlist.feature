Feature: Playlist
  In order to verify BBC media applications features
  As a test engineer
  I want to be able to create bespoke playlists of media assets

  Scenario: A live Simulacast
    When I ask for the playlist for "BBC One London" live simulcast
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <item kind="programme" live="true" simulcast="true" group="deprecated" identifier="bbc-one-london-pid-deprecated">
        <mediator identifier="bbc-one-london-pid" name="deprecated"/>
      </item>
    </playlist>
    """
    
  Scenario: A Simulacast with live rewind
    When I ask for the playlist for "BBC One London" live rewind simulcast
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <item kind="programme" live="true" simulcast="true" liverewind="true" group="deprecated" identifier="bbc-one-london-pid-deprecated">
        <mediator identifier="bbc-one-london-pid" name="deprecated"/>
      </item>
    </playlist>
    """
    
  Scenario: An programme with guidance warning
    When I ask for the playlist for a "Video on demand with guidance warning" 
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <item kind="programme" duration="5700" availability_class="ondemand" group="deprecated" identifier="video-on-demand-pid-deprecated">
        <guidance>An example of a guidance warning</guidance>
        <mediator identifier="video-on-demand-pid" name="deprecated"/>
      </item>
    </playlist>
    """

  Scenario: A video on demand 
    When I ask for the playlist for a "Video on demand" 
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <item kind="programme" duration="5700" availability_class="ondemand" group="deprecated" identifier="video-on-demand-pid-deprecated">
        <mediator identifier="video-on-demand-pid" name="deprecated"/>
      </item>
    </playlist>
    """

  Scenario: A audio on demand 
    When I ask for the playlist for a "Audio on demand" 
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <item kind="radioProgramme" duration="5700" availability_class="ondemand" group="deprecated" identifier="audio-on-demand-pid-deprecated">
        <mediator identifier="audio-on-demand-pid" name="deprecated"/>
      </item>
    </playlist>
    """
    
  Scenario: An ident and a video on demand 
    When I ask for the playlist with a "ident" and "Video on demand" 
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <item kind="ident">
        <mediator identifier="ident-pid" name="deprecated"/>
      </item>
      <item kind="programme" duration="5700" availability_class="ondemand" group="deprecated" identifier="video-on-demand-pid-deprecated">
        <mediator identifier="video-on-demand-pid" name="deprecated"/>
      </item>
    </playlist>
    """
  
  Scenario: Pre-availablity
    When I ask for the playlist for a servcie that hasn't started broadcasting yet
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <noItems reason="preAvailability"/>
    </playlist>
    """
  
  Scenario: Post live availablity
    When I ask for the playlist for a live programme that has finished broadcasting
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <noItems reason="postLiveAvailability"/>
    </playlist>
    """
  
  Scenario: Post availablity
    When I ask for the playlist for a programme that has finished broadcasting
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <noItems reason="postAvailability"/>
    </playlist>
    """
    
  Scenario: Off air
    When I ask for a playlist for a service that is currently off air
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <noItems reason="offAir"/>
    </playlist>
    """    
  
  Scenario: No known reason why playlist is empty
    When I ask for a playlist that is empty for no reason
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <noItems reason="unknown"/>
    </playlist>
    """
    
  Scenario: Playlist has no playable media
    When I ask for a playlist that has no playable items
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <noItems reason="noPlayableItems"/>
    </playlist>
    """
  
  Scenario: Playlist has media unavailable to international users
    When I ask for a playlist whose media unavailable to international users
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <noItems reason="regionRestriction"/>
    </playlist>
    """

  Scenario: Playlist has no media
    When I ask for a playlist which has no media
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <noItems reason="noMedia"/>
    </playlist>

    """
    
  Scenario: Playlist is missing media
    When I ask for a playlist whose media is missing
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <item kind="programme" group="deprecated" identifier="deprecated"/>
    </playlist>
    """
    
  Scenario: Malformed playlist
    When I ask for the playlist with a "ident" and "Video on demand" 
    But the playlist is malformed
    Then I should not get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <item kind="ident">
        <mediator identifier="ident_pid"/>
      </item>
      <item kind="programme" duration="5700" availability_class="ondemand" name="deprecated">
        <mediator identifier="video-on-demand-pid"/>
      </item>
    </playlist>
    """

  Scenario: item contains hds
    When I ask for the playlist for "Olympics" live rewind
    Then I should get the playlist:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <playlist xmlns="http://bbc.co.uk/2008/emp/playlist" revision="1">
      <item kind="programme" live="true" liverewind="true" group="deprecated" identifier="the-olympics-deprecated">
        <media bitrate="1500" encoding="h264" type="video/mp4" width="832">
          <connection href="http://www.bbc.co.uk/playlists/olympics.f4m" protocol="http" supplier="akamai_hds" transferFormat="hds"/>
          <connection href="http://www.bbc.co.uk/playlists/olympics.f4m" protocol="http" supplier="third_wave" transferFormat="hls"/>
        </media>
        <media bitrate="800" encoding="h264" type="video/mp4" width="832">
          <connection href="http://www.bbc.co.uk/playlists/olympics.f4m" protocol="rtmp" supplier="limelight" transferFormat="hds"/>
        </media>
      </item>
    </playlist>
    """
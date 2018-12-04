function initVideoCall(){

  const button = document.getElementById('my-button');

  if (button) {

    const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzg0ZGU5OGEwZmMzNzk0NTA2MThlNTdlMzVlODdlY2NkLTE1NDM5MzQ5NjciLCJpc3MiOiJTSzg0ZGU5OGEwZmMzNzk0NTA2MThlNTdlMzVlODdlY2NkIiwic3ViIjoiQUNjYWY4MDcxZDBmYmRmNTc5OTFlMTk4Y2ExN2YyYzhiNSIsImV4cCI6MTU0MzkzODU2NywiZ3JhbnRzIjp7ImlkZW50aXR5IjoiZGFuIiwidmlkZW8iOnt9fX0.8opEKZZrv9AMyiFNZ1SZI4haA1xBWKMYKlJAMMT3KeQ';
    const { connect, createLocalVideoTrack } = require('twilio-video');


    button.addEventListener('click', (event) => {
      console.log("hello video");

      connect(token, {
        audio: true,
        name: 'test-room',
        video: { width: 640 }
      }).then(room => {
        console.log(`Successfully joined a Room: ${room}`);

        const localParticipant = room.localParticipant;
        console.log(`Connected to the Room as LocalParticipant "${localParticipant.identity}"`);

        // Log any Participants already connected to the Room
        room.participants.forEach(participant => {
          console.log(`Participant "${participant.identity}" is already connected to the Room`);

          participant.tracks.forEach(track => {
            document.getElementById('remote-media').appendChild(track.attach());
          });

          participant.on('trackAdded', track => {
            document.getElementById('remote-media').appendChild(track.attach());
          });


        });

        // Log new Participants as they connect to the Room
        room.once('participantConnected', participant => {
          console.log(`Participant "${participant.identity}" has just connected to the Room`);


          participant.tracks.forEach(track => {
            document.getElementById('remote-media').appendChild(track.attach());
          });

          participant.on('trackAdded', track => {
            document.getElementById('remote-media').appendChild(track.attach());
          });

        });

        // Log Participants as they disconnect from the Room
        room.once('participantDisconnected', participant => {
          console.log(`Participant "${participant.identity}" has disconnected from the Room`);
        });



      }, error => {
        console.error(`Unable to connect to Room: ${error.message}`);
      });


      createLocalVideoTrack().then(track => {
        const localMediaContainer = document.getElementById('local-media');
        localMediaContainer.appendChild(track.attach());
      });

    });

  }
}

export {initVideoCall};

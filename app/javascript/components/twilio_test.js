function initVideoCall(){

  const button = document.getElementById('my-button');

  if (button) {

    const { connect, createLocalVideoTrack } = require('twilio-video');


    button.addEventListener('click', (event) => {
      console.log("hello video");
      const token = document.getElementById('token').value;

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

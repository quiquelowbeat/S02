use youtube

db.users.insertMany([
    {
        "_id": 1,
        "email": "themaster@youtube.com",
        "password": "Yhukeoir83902",
        "user_name": "themaster",
        "dob": new Date("1983-04-23"),
        "gender": "M",
        "country": "USA",
        "zipcode": "08345",
        "published_videos": [
            {"video_id": 1},
            {"video_id": 3}
        ],
        "liked_videos": [
            {
                "video_id": 2, 
                "datetime": new Date("2022-01-31T13:59:08Z")
            }
        ],
        "disliked_videos": [null],
    },

    {
        "_id": 2,
        "email": "thesecondmaster@youtube.com",
        "password": "LLLkeoir8",
        "user_name": "thesecondmaster",
        "dob": new Date("1981-06-02"),
        "gender": "F",
        "country": "Spain",
        "zipcode": "08345",
        "published_videos": [
            {"video_id": 4},
        ],
        "liked_videos": [null],
        "disliked_videos": [
            {
                "video_id": 1, 
                "datetime": new Date("2021-12-31T21:55:56Z")
            }
        ],
    },

    {
        "_id": 3,
        "email": "thethirdmaster@youtube.com",
        "password": "LLLktttttoir8",
        "user_name": "thethirdmaster",
        "dob": new Date("1975-01-02"),
        "gender": "M",
        "country": "Austria",
        "zipcode": "08334",
        "published_videos": [
            {"video_id": 2},
        ],
        "liked_videos": [null],
        "disliked_videos": [
            {
                "video_id": 4, 
                "datetime": new Date("2020-09-12T20:08:43Z")
            },
            {
                "video_id": 3, 
                "datetime": new Date("2022-01-31T13:58:11Z")
            },

        ],
    }
])

db.videos.insertMany([
    {
        "_id": 1,
        "title": "Funny Angry Cat",
        "description": "Funny cat doing random bad things",
        "size": 23.5,
        "filename": "funnyangrycat.mp4",
        "video_length": "04:35:04",
        "thumbnail_url": "youtube.com/woquefyghqwoeuyfgqwe.jpg",
        "views": 67,
        "likes_qty": 0,
        "dislikes_qty": 1,
        "status": "public",
        "publish_datetime": new Date("2021-12-31T21:54:03Z"),
        "tags": [1,2],
        "playlist_id": [1, 2]
    },

    {
        "_id": 2,
        "title": "Funny Dog",
        "description": "Funny dog running.",
        "size": 21.5,
        "filename": "funnydog.mp4",
        "video_length": "01:32:04",
        "thumbnail_url": "youtube.com/woquefyghdogdogqwe.jpg",
        "views": 6567,
        "likes_qty": 1,
        "dislikes_qty": 0,
        "status": "public",
        "publish_datetime": new Date("2022-01-31T13:52:01Z"),
        "tags": [1,2],
        "playlist_id": [1]
    },

    {
        "_id": 3,
        "title": "Angry Bird",
        "description": "Angry bird flying.",
        "size": 20.4,
        "filename": "angrybird.mp4",
        "video_length": "01:30:07",
        "thumbnail_url": "youtube.com/woqoiuqwhefeuyfgqwe.jpg",
        "views": 67000,
        "likes_qty": 0,
        "dislikes_qty": 1,
        "status": "private",
        "publish_datetime": new Date("2021-12-31T21:54:03Z"),
        "tags": [2],
        "playlist_id": [2]
    },

    {
        "_id": 4,
        "title": "Dinosaur on drugs",
        "description": "Dinosaur partying hard.",
        "size": 19.4,
        "filename": "dinolsd.mp4",
        "video_length": "01:39:01",
        "thumbnail_url": "youtube.com/qwiefuhqwoefiuh.jpg",
        "views": 671,
        "likes_qty": 0,
        "dislikes_qty": 1,
        "status": "hidden",
        "publish_datetime": new Date("2020-09-12T20:04:13Z"),
        "tags": [1, 2, 3],
        "playlist_id": [2, 3]
    }
    
])

db.tags.insertMany([
    {
        "_id": 1,
        "name": "funny"
    },

    {
        "_id": 2,
        "name": "animals"
    },

    {
        "_id": 3,
        "name": "dancing"
    },
])

db.playlists.insertMany([
    {
        "_id": 1,
        "name": "Vídeos de gatitos",
        "date_created": new Date("2018-08-23"),
        "created_by": {
            "user_id": 1
        },
        "shared_with":[
            {
                "user_id": 2,
            },
            {
                "user_id": 3,
            }
        ],
        "status": "public"
    },

    {
        "_id": 2,
        "name": "Vídeos de animales",
        "date_created": new Date("2019-01-20"),
        "created_by": {
            "user_id": 2
        },
        "shared_with":[null],
        "status": "private"
    },


    {
        "_id": 3,
        "name": "Vídeos divertidos de fiestas",
        "date_created": new Date("2011-11-30"),
        "created_by": {
            "user_id": 3
        },
        "shared_with":[
            {
                "user_id": 1,
            },
            {
                "user_id": 2,
            }
        ],
        "status": "public"
    },

])

db.comments.insertMany([
    {
        "_id": 1,
        "user_id": 2,
        "video_id": 1,
        "text": "Qué divertido.",
        "datetime": new Date("2022-02-03T21:45:34Z"),
        "liked_by": [
            {
                "user_id": 1, 
                "datetime": new Date("2022-02-03T22:45:05Z")
            },

            {
                "user_id": 3, 
                "datetime": new Date("2022-02-03T22:57:05Z")
            }
        ],
        "disliked_by": [null]
    },

    {
        "_id": 2,
        "user_id": 1,
        "video_id": 4,
        "text": "Qué dinosaurio más molón.",
        "datetime": new Date("2021-07-04T20:40:30Z"),
        "liked_by": [
            {
                "user_id": 2, 
                "datetime": new Date("2021-07-04T20:40:30Z")
            }
        ],
        "disliked_by": [
            {
                "user_id": 3, 
                "datetime": new Date("2022-02-03T22:57:05Z")
            }
        ]
    }

])

db.channels.insertMany([
    {
        "_id": 1,
        "name": "El canal de Paco",
        "created_by": 
            {
                "user_id": 1
            },
        "description": "Canal de recetas estrafalarias.",
        "date_created": new Date("2017-07-04T20:40:30Z"),
        "subscribers":[
            {"user_id": 2},
            {"user_id": 3}
            ]
    },

    {
        "_id": 2,
        "name": "Ninja tapes",
        "created_by": 
            {
                "user_id": 2
            },
        "description": "Canal de vídeos de ninjas.",
        "date_created": new Date("2015-02-06T19:42:36Z"),
        "subscribers":[
            {"user_id": 1},
            ]
    }

])


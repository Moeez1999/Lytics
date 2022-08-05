
import 'dart:convert';

List<Jobs> jobsFromJson(String str) => List<Jobs>.from(json.decode(str).map((x) => Jobs.fromJson(x)));

String jobsToJson(List<Jobs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jobs {
  Jobs({
    this.activeDownload,
    this.engineSentiment,
    this.programDescription,
    this.videoPath,
    this.thumbnailPath,
    this.comments,
    this.anchor,
    this.priority,
    this.language,
    this.region,
    this.jobState,
    this.readyFor,
    this.clippedBy,
    this.markedBy,
    this.qcBy,
    this.engineStatus,
    this.transcriptionEngine,
    // this.translationEngine,
    this.transcription,
    // this.translation,
    this.output,
    this.impact,
    this.tags,
    this.wordCount,
    this.channel,
    this.channelLogoPath,
    this.programTime,
    this.programName,
    this.programType,
    this.programDate,
    this.segments,
    this.escalations,
    this.actus,
    this.videoLength,
    this.engineExpectedTime,
    this.id,
  });

  bool? activeDownload;
  List<dynamic>? engineSentiment;
  String? programDescription;
  String? videoPath;
  String? thumbnailPath;
  String? comments;
  List<String>? anchor;
  String? priority;
  String? language;
  String? region;
  String? jobState;
  List<String>? readyFor;
  String? clippedBy;
  String? markedBy;
  String? qcBy;
  String? engineStatus;
  List<TranscriptionEngine>? transcriptionEngine;
  // List<Translation>? translationEngine;
  List<Transcription>? transcription;
  // List<Translation>? translation;
  Output? output;
  Impact? impact;
  List<String>? tags;
  int? wordCount;
  String? channel;
  String? channelLogoPath;
  String? programTime;
  String? programName;
  String? programType;
  DateTime? programDate;
  List<Segment>? segments;
  List<dynamic>? escalations;
  Actus? actus;
  String? videoLength;
  String? engineExpectedTime;
  String? id;

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
    activeDownload: json["activeDownload"],
    engineSentiment: List<dynamic>.from(json["engineSentiment"].map((x) => x)),
    programDescription: json["programDescription"],
    videoPath: json["videoPath"],
    thumbnailPath: json["thumbnailPath"],
    comments: json["comments"],
    anchor: List<String>.from(json["anchor"].map((x) => x)),
    priority: json["priority"],
    language: json["language"],
    region: json["region"],
    jobState: json["jobState"],
    readyFor: List<String>.from(json["readyFor"].map((x) => x)),
    clippedBy: json["clippedBy"],
    markedBy: json["markedBy"],
    qcBy: json["qcBy"],
    engineStatus: json["engineStatus"],
    transcriptionEngine: List<TranscriptionEngine>.from(json["transcription_engine"].map((x) => TranscriptionEngine.fromJson(x))),
    // translationEngine: List<Translation>.from(json["translation_engine"].map((x) => Translation.fromJson(x))),
    transcription: List<Transcription>.from(json["transcription"].map((x) => Transcription.fromJson(x))),
    // translation: List<Translation>.from(json["translation"].map((x) => Translation.fromJson(x))),
    output: Output.fromJson(json["output"]),
    impact: Impact.fromJson(json["impact"]),
    tags: List<String>.from(json["tags"].map((x) => x)),
    wordCount: json["wordCount"],
    channel: json["channel"],
    channelLogoPath: json["channelLogoPath"],
    programTime: json["programTime"],
    programName: json["programName"],
    programType: json["programType"],
    programDate: DateTime.parse(json["programDate"]),
    segments: List<Segment>.from(json["segments"].map((x) => Segment.fromJson(x))),
    escalations: List<dynamic>.from(json["escalations"].map((x) => x)),
    actus: Actus.fromJson(json["actus"]),
    videoLength: json["videoLength"],
    engineExpectedTime: json["engineExpectedTime"],

    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "activeDownload": activeDownload,
    "engineSentiment": List<dynamic>.from(engineSentiment!.map((x) => x)),
    "programDescription": programDescription,
    "videoPath": videoPath,
    "thumbnailPath": thumbnailPath,
    "comments": comments,
    "anchor": List<dynamic>.from(anchor!.map((x) => x)),
    "priority": priority,
    "language": language,
    "region": region,
    "jobState": jobState,
    "readyFor": List<dynamic>.from(readyFor!.map((x) => x)),
    "clippedBy": clippedBy,
    "markedBy": markedBy,
    "qcBy": qcBy,
    "engineStatus": engineStatus,
    "transcription_engine": List<dynamic>.from(transcriptionEngine!.map((x) => x.toJson())),
    // "translation_engine": List<dynamic>.from(translationEngine!.map((x) => x.toJson())),
    "transcription": List<dynamic>.from(transcription!.map((x) => x.toJson())),
    // "translation": List<dynamic>.from(translation!.map((x) => x.toJson())),
    "output": output!.toJson(),
    "impact": impact!.toJson(),
    "tags": List<dynamic>.from(tags!.map((x) => x)),
    "wordCount": wordCount,
    "channel": channel,
    "channelLogoPath": channelLogoPath,
    "programTime": programTime,
    "programName": programName,
    "programType": programType,
    "programDate": programDate!.toIso8601String(),
    "segments": List<dynamic>.from(segments!.map((x) => x.toJson())),
    "escalations": List<dynamic>.from(escalations!.map((x) => x)),
    "actus": actus!.toJson(),
    "videoLength": videoLength,
    "engineExpectedTime": engineExpectedTime,

    "id": id,
  };
}

class Actus {
  Actus({
    this.jobId,
    this.status,
    this.updatedAt,
  });

  int? jobId;
  String? status;
  int? updatedAt;

  factory Actus.fromJson(Map<String, dynamic> json) => Actus(
    jobId: json["jobId"],
    status: json["status"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "jobId": jobId,
    "status": status,
    "updatedAt": updatedAt,
  };
}

// class Guest {
//   Guest({
//     this.name,
//     this.description,
//     this.association,
//   });
//
//   String? name;
//   String? description;
//   String? association;
//
//   factory Guest.fromJson(Map<String, dynamic> json) => Guest(
//     name: json["name"],
//     description: json["description"],
//     association: json["association"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "description": description,
//     "association": association,
//   };
// }

class Impact {
  Impact({
    this.onlineViews,
    this.tvRatings,
    this.webMentions,
  });

  String? onlineViews;
  String? tvRatings;
  String? webMentions;

  factory Impact.fromJson(Map<String, dynamic> json) => Impact(
    onlineViews: json["onlineViews"],
    tvRatings: json["tvRatings"],
    webMentions: json["webMentions"],
  );

  Map<String, dynamic> toJson() => {
    "onlineViews": onlineViews,
    "tvRatings": tvRatings,
    "webMentions": webMentions,
  };
}

class Output {
  Output({
    this.programType,
    this.format,
    this.frameSizePixel,
    this.frameSize,
  });

  String? programType;
  String? format;
  String? frameSizePixel;
  String? frameSize;

  factory Output.fromJson(Map<String, dynamic> json) => Output(
    programType: json["programType"],
    format: json["format"],
    frameSizePixel: json["frameSizePixel"],
    frameSize: json["frameSize"],
  );

  Map<String, dynamic> toJson() => {
    "programType": programType,
    "format": format,
    "frameSizePixel": frameSizePixel,
    "frameSize": frameSize,
  };
}

class Segment {
  Segment({
    this.segmentAnalysis,
    this.themes,
    this.title,
    this.color,
    this.time,
    this.guestAnalysis,
  });

  SegmentAnalysis? segmentAnalysis;
  Themes? themes;
  String? title;
  String? color;
  double? time;
  List<GuestAnalysis>? guestAnalysis;

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
    segmentAnalysis: SegmentAnalysis.fromJson(json["segmentAnalysis"]),
    themes: Themes.fromJson(json["themes"]),
    title: json["title"],
    color: json["color"],
    time: json["time"].toDouble(),
    guestAnalysis: List<GuestAnalysis>.from(json["guestAnalysis"].map((x) => GuestAnalysis.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "segmentAnalysis": segmentAnalysis!.toJson(),
    "themes": themes!.toJson(),
    "title": title,
    "color": color,
    "time": time,
    "guestAnalysis": List<dynamic>.from(guestAnalysis!.map((x) => x.toJson())),
  };
}

class GuestAnalysis {
  GuestAnalysis({
    this.guest,
    this.statement,
    this.sentiment,
  });

  String? guest;
  String? statement;
  String? sentiment;

  factory GuestAnalysis.fromJson(Map<String, dynamic> json) => GuestAnalysis(
    guest: json["guest"],
    statement: json["statement"],
    sentiment: json["sentiment"],
  );

  Map<String, dynamic> toJson() => {
    "guest": guest,
    "statement": statement,
    "sentiment": sentiment,
  };
}

class SegmentAnalysis {
  SegmentAnalysis({
    this.anchor,
    this.analysis,
    this.trend,
    this.summary,
  });

  Anchor? anchor;
  Analysis? analysis;
  Trend? trend;
  List<Summary>? summary;

  factory SegmentAnalysis.fromJson(Map<String, dynamic> json) => SegmentAnalysis(
    anchor: Anchor.fromJson(json["anchor"]),
    analysis: Analysis.fromJson(json["analysis"]),
    trend: Trend.fromJson(json["trend"]),
    summary: List<Summary>.from(json["summary"].map((x) => Summary.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "anchor": anchor!.toJson(),
    "analysis": analysis!.toJson(),
    "trend": trend!.toJson(),
    "summary": List<dynamic>.from(summary!.map((x) => x.toJson())),
  };
}

class Analysis {
  Analysis({
    this.scale,
    this.analyst,
  });

  String? scale;
  String? analyst;

  factory Analysis.fromJson(Map<String, dynamic> json) => Analysis(
    scale: json["scale"],
    analyst: json["analyst"],
  );

  Map<String, dynamic> toJson() => {
    "scale": scale,
    "analyst": analyst,
  };
}

class Anchor {
  Anchor({
    this.name,
    this.scale,
    this.description,
    this.sentiment,
  });

  String? name;
  String? scale;
  String? description;
  String? sentiment;

  factory Anchor.fromJson(Map<String, dynamic> json) => Anchor(
    name: json["name"],
    scale: json["scale"],
    description: json["description"],
    sentiment: json["sentiment"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "scale": scale,
    "description": description,
    "sentiment": sentiment,
  };
}

class Summary {
  Summary({
    this.statement,
    this.participant,
    this.pillar,
    this.sentiment,
  });

  String? statement;
  String? participant;
  String? pillar;
  String? sentiment;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    statement: json["statement"],
    participant: json["participant"],
    pillar: json["pillar"],
    sentiment: json["sentiment"],
  );

  Map<String, dynamic> toJson() => {
    "statement": statement,
    "participant": participant,
    "pillar": pillar,
    "sentiment": sentiment,
  };
}

class Trend {
  Trend({
    this.govt,
    this.opposition,
    this.judiciary,
    this.armedForces,
    this.isi,
    this.media,
  });

  String? govt;
  String? opposition;
  String? judiciary;
  String? armedForces;
  String? isi;
  String? media;

  factory Trend.fromJson(Map<String, dynamic> json) => Trend(
    govt: json["govt"],
    opposition: json["opposition"],
    judiciary: json["judiciary"],
    armedForces: json["armedForces"],
    isi: json["isi"],
    media: json["media"],
  );

  Map<String, dynamic> toJson() => {
    "govt": govt,
    "opposition": opposition,
    "judiciary": judiciary,
    "armedForces": armedForces,
    "isi": isi,
    "media": media,
  };
}

class Themes {
  Themes({
    this.mainTheme,
    this.subTheme,
  });

  String? mainTheme;
  List<String>? subTheme;

  factory Themes.fromJson(Map<String, dynamic> json) => Themes(
    mainTheme: json["mainTheme"],
    subTheme: List<String>.from(json["subTheme"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "mainTheme": mainTheme,
    "subTheme": List<dynamic>.from(subTheme!.map((x) => x)),
  };
}

class Transcription {
  Transcription({
    this.duration,
    this.speaker,
    this.line,
  });

  String? duration;
  Speaker? speaker;
  String? line;

  factory Transcription.fromJson(Map<String, dynamic> json) => Transcription(
    duration: json["duration"],
    speaker: speakerValues.map![json["speaker"]],
    line: json["line"],
  );

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "speaker": speakerValues.reverse![speaker],
    "line": line,
  };
}

enum Speaker { S105, S107, S14, S104, S1 }

final speakerValues = EnumValues({
  "S1\n": Speaker.S1,
  "S104\n": Speaker.S104,
  "S105\n": Speaker.S105,
  "S107\n": Speaker.S107,
  "S14\n": Speaker.S14
});

class TranscriptionEngine {
  TranscriptionEngine({
    this.duration,
    this.line,
    this.gender,
    this.band,
    this.env,
    this.speaker,
  });

  String? duration;
  String? line;
  Gender? gender;
  Band? band;
  Env? env;
  Speaker? speaker;

  factory TranscriptionEngine.fromJson(Map<String, dynamic> json) => TranscriptionEngine(
    duration: json["duration"],
    line: json["line"],
    gender: genderValues.map![json["gender"]],
    band: bandValues.map![json["band"]],
    env: envValues.map![json["env"]],
    speaker: speakerValues.map![json["speaker"]],
  );

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "line": line,
    "gender": genderValues.reverse![gender],
    "band": bandValues.reverse![band],
    "env": envValues.reverse![env],
    "speaker": speakerValues.reverse![speaker],
  };
}

enum Band { S }

final bandValues = EnumValues({
  "S": Band.S
});

enum Env { U }

final envValues = EnumValues({
  "U": Env.U
});

enum Gender { F, M }

final genderValues = EnumValues({
  "F": Gender.F,
  "M": Gender.M
});

class Translation {
  Translation({
    this.duration,
    this.line,
  });

  String? duration;
  String? line;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    duration: json["duration"],
    line: json["line"],
  );

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "line": line,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

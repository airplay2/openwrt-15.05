m = Map("ffmpegtool", translate("FFMPEG-Tool"))

m:section(SimpleSection).template  = "ffmpegtool_status"

s = m:section(TypedSection, "ffmpegtool", "", translate("Assistant for FFMPEG"))
s.anonymous = true
s.addremove = false

s:tab("ffmpegbasic", translate("Basic Setting"))

src_select=s:taboption("ffmpegbasic", ListValue, "src_select", translate("Source Select"))
src_select.placeholder = "one file"
src_select:value("one file",translate("one file"))
src_select:value("all files in the directory",translate("all files in the directory"))
src_select:value("streaming media",translate("streaming media"))
src_select.default = "one file"
src_select.rempty  = false

src_file_path=s:taboption("ffmpegbasic", Value, "src_file_path", translate("Source File"))
src_file_path:depends( "src_select", "one file" )
src_file_path.rmempty = true
src_file_path.datatype = "string"
src_file_path.default = "/mnt/sda1/input.mp3"
src_file_path.description = translate("please input audio/video/picture file fullpath")

src_directory_path=s:taboption("ffmpegbasic", Value, "src_directory_path", translate("Source Directory"))
src_directory_path:depends( "src_select", "all files in the directory" )
src_directory_path.rmempty = true
src_directory_path.datatype = "string"
src_directory_path.default = "/mnt/sda1"
src_directory_path.description = translate("please input directory path")

src_stream_path=s:taboption("ffmpegbasic", Value, "src_stream_path", translate("Streaming media url"))
src_stream_path:depends( "src_select", "streaming media" )
src_stream_path.rmempty = true
src_stream_path.datatype = "string"
src_stream_path.default = "rtmp://ip:1935/stream"
src_stream_path.description = translate("like rtmp,m3u8 and so on")

dest_select=s:taboption("ffmpegbasic", ListValue, "dest_select", translate("Destination Select"))
dest_select.placeholder = "directory"
dest_select:value("directory",translate("directory"))
dest_select:value("Sound Card",translate("Sound Card"))
dest_select.default = "directory"
dest_select.rempty  = false

dest_directory_path=s:taboption("ffmpegbasic", Value, "dest_directory_path", translate("Destination Directory Path"))
dest_directory_path:depends( "dest_select", "directory" )
dest_directory_path.rmempty = true
dest_directory_path.datatype = "string"
dest_directory_path.default = "/mnt/sda1"
dest_directory_path.description = translate("do not be the same as the source directory")

srcinfo = s:taboption("ffmpegbasic", Button, "srcinfo", translate("One-click Get infomation"))
srcinfo:depends( "audio_ready", "1" )
srcinfo.rmempty = true
srcinfo.inputstyle = "apply"
function srcinfo.write(self, section)
	luci.util.exec("sh /usr/ffmpegtool/getinfo >/dev/null 2>&1 &")
end

s:tab("audio_setting", translate("Audio Setting"))

audio_format=s:taboption("audio_setting", ListValue, "audio_format", translate("Audio format"))
audio_format.placeholder = "mp3"
audio_format:value("mp3")
audio_format:value("m4a")
audio_format:value("wmv")
audio_format:value("aac")
audio_format:value("ts")
audio_format:value("wav")
audio_format.default = "mp3"
audio_format.rempty  = false

sampling_rate=s:taboption("audio_setting", ListValue, "sampling_rate", translate("Sampling rate"))
sampling_rate.placeholder = "none"
sampling_rate:value("none")
sampling_rate:value("44100")
sampling_rate:value("22050")
sampling_rate:value("11025")
sampling_rate.default = "none"
sampling_rate.rempty  = false

audio_channel=s:taboption("audio_setting", ListValue, "audio_channel", translate("Audio channel"))
audio_channel.placeholder = "none"
audio_channel:value("none")
audio_channel:value("1",translate("mono"))
audio_channel:value("2",translate("stereo"))
audio_channel.default = "none"
audio_channel.rempty  = false

a_modify_duration=s:taboption("audio_setting", ListValue, "a_modify_duration", translate("Modify duration"))
a_modify_duration.placeholder = "do not modify"
a_modify_duration:value("do not modify",translate("do not modify"))
a_modify_duration:value("specific time period",translate("specific time period"))
a_modify_duration:value("cut head and tail",translate("cut head and tail"))
a_modify_duration.default = "do not modify"
a_modify_duration.rempty  = false

audio_starttime=s:taboption("audio_setting", Value, "audio_starttime", translate("Start time"))
audio_starttime:depends( "a_modify_duration", "specific time period" )
audio_starttime.datatype = "string"
audio_starttime.placeholder = "00:00:00.00"
audio_starttime.default = "00:00:00.00"
audio_starttime.rmempty = true

audio_endtime=s:taboption("audio_setting", Value, "audio_endtime", translate("End time"))
audio_endtime:depends( "a_modify_duration", "specific time period" )
audio_endtime.datatype = "string"
audio_endtime.placeholder = "00:01:30.00"
audio_endtime.default = "00:01:30.00"
audio_endtime.rmempty = true

audio_headtime=s:taboption("audio_setting", Value, "audio_headtime", translate("cut head"))
audio_headtime:depends( "a_modify_duration", "cut head and tail" )
audio_headtime.datatype = "string"
audio_headtime.placeholder = "15"
audio_headtime.default = "15"
audio_headtime.rmempty = true

audio_tailtime=s:taboption("audio_setting", Value, "audio_tailtime", translate("cut tail"))
audio_tailtime:depends( "a_modify_duration", "cut head and tail" )
audio_tailtime.datatype = "string"
audio_tailtime.placeholder = "10"
audio_tailtime.default = "10"
audio_tailtime.rmempty = true

risingfalling_tone=s:taboption("audio_setting", ListValue, "risingfalling_tone", translate("Rising-Falling tone"))
risingfalling_tone.placeholder = "none"
risingfalling_tone:value("none")
risingfalling_tone:value("sharp(44100Hz)",translate("sharp(44100Hz)"))
risingfalling_tone:value("sharp(22050Hz)",translate("sharp(22050Hz)"))
risingfalling_tone:value("rasing whole tone(44100Hz)",translate("rasing whole tone(44100Hz)"))
risingfalling_tone:value("rasing whole tone(22050Hz)",translate("rasing whole tone(22050Hz)"))
risingfalling_tone:value("flat(44100Hz)",translate("flat(44100Hz)"))
risingfalling_tone:value("flat(22050Hz)",translate("flat(22050Hz)"))
risingfalling_tone:value("falling whole tone(44100Hz)",translate("falling whole tone(44100Hz)"))
risingfalling_tone:value("falling whole tone(22050Hz)",translate("falling whole tone(22050Hz)"))
risingfalling_tone.default = "none"
risingfalling_tone.rempty  = false
risingfalling_tone.description = translate("increase CPU loading")

a_speed_governing=s:taboption("audio_setting", ListValue, "a_speed_governing", translate("Speed governing"))
a_speed_governing.placeholder = "none"
a_speed_governing:value("none")
a_speed_governing:value("0.5")
a_speed_governing:value("1.0")
a_speed_governing:value("1.5")
a_speed_governing:value("2.0")
a_speed_governing.default = "none"
a_speed_governing.rempty  = false
a_speed_governing.description = translate("increase CPU loading")

volume=s:taboption("audio_setting", ListValue, "volume", translate("Volume"))
volume.placeholder = "none"
volume:value("none")
volume:value("standard")
volume:value("+5dB")
volume:value("-5dB")
volume.default = "none"
volume.rempty  = false
volume.description = translate("increase CPU loading")

audio_title = s:taboption("audio_setting", Flag, "audio_title", translate("about title"))

audio_addtitle = s:taboption("audio_setting", Flag, "audio_addtitle", translate("set title"))
audio_addtitle:depends( "audio_title", "1" )
audio_addtitle.default = "0"

audio_titleisname = s:taboption("audio_setting", Flag, "audio_titleisname", translate("replace filename with title"))
audio_titleisname:depends( "audio_title", "1" )
audio_titleisname.default = "0"

audio_copy = s:taboption("audio_setting", Flag, "audio_copy", translate("Fast copy"))
audio_copy:depends({ risingfalling_tone = "none", a_speed_governing = "none", volume = "none", audio_title = "", sampling_rate = "none", audio_channel = "none" })

audio_ready = s:taboption("audio_setting", Flag, "audio_ready", translate("Setup ready"))
audio_ready.description = translate("Save/apply first please")

s:tab("video_setting", translate("Video Setting"))
video_format=s:taboption("video_setting", ListValue, "video_format", translate("Video format"))
video_format.placeholder = "mp4"
video_format:value("mp4")
video_format:value("mkv")
video_format:value("avi")
video_format:value("wmv")
video_format:value("ts")
video_format:value("flv")
video_format:value("3gp")
video_format.default = "mp4"
video_format.rempty  = false

video_x2645=s:taboption("video_setting", ListValue, "video_x2645", translate("using libx264/libx265"))
video_x2645:value("none")
video_x2645:value("libx264")
video_x2645:value("libx265")
video_x2645.description = translate("increase CPU loading")

image_effects=s:taboption("video_setting", Flag, "image_effects", translate("image effects"))
image_effects:depends( "screen_merge", "" )
image_effects.description = translate("increase CPU loading when open")

video_horizontally = s:taboption("video_setting", Flag, "video_horizontally", translate("flip image horizontally"))
video_horizontally:depends( "image_effects", "1" )

video_upanddown = s:taboption("video_setting", Flag, "video_upanddown", translate("flip image up and down"))
video_upanddown:depends( "image_effects", "1" )

video_rotation = s:taboption("video_setting", Flag, "video_rotation", translate("image rotation 90 degrees"))
video_rotation:depends( "image_effects", "1" )

horizontal_symmetrical = s:taboption("video_setting", Flag, "horizontal_symmetrical", translate("image horizontal symmetrical"))
horizontal_symmetrical:depends( "image_effects", "1" )

vertically_symmetrical = s:taboption("video_setting", Flag, "vertically_symmetrical", translate("image vertically symmetrical"))
vertically_symmetrical:depends( "image_effects", "1" )

fuzzy_processing = s:taboption("video_setting", Flag, "fuzzy_processing", translate("fuzzy processing"))
fuzzy_processing:depends( "image_effects", "1" )

crisp_enhancement = s:taboption("video_setting", Flag, "crisp_enhancement", translate("crisp enhancement"))
crisp_enhancement:depends( "image_effects", "1" )

video_halfsize = s:taboption("video_setting", Flag, "video_halfsize", translate("a half of screensize"))
video_halfsize:depends( "image_effects", "1" )

video_clipping = s:taboption("video_setting", Flag, "video_clipping", translate("screen clipping"))
video_clipping:depends( "image_effects", "1" )

video_crop = s:taboption("video_setting", Value, "video_crop", translate("capture the screen of the specified size and location"))
video_crop:depends( "video_clipping", "1" )
video_crop.datatype = "string"
video_crop.placeholder = "crop=iw:ih/2:0:100"
video_crop.default = "crop=iw:ih/2:0:100"
video_crop.rmempty = true
video_crop.description = translate("default set is capture 100% width and 50% heigh from the topleft (0,100) pixel")

video_blackandwhite = s:taboption("video_setting", Flag, "video_blackandwhite", translate("black-and-white"))
video_blackandwhite:depends( "image_effects", "1" )

screen_merge=s:taboption("video_setting", Flag, "screen_merge", translate("screen merge"))
screen_merge.default = ""
screen_merge.description = translate("only modification duration is supported")

enable_merge=s:taboption("video_setting", ListValue, "enable_merge", translate("enable merge"))
enable_merge:depends( "screen_merge", "1" )
enable_merge:value("left and right",translate("left and right"))
enable_merge:value("top and bottom",translate("top and bottom"))
enable_merge:value("one by one",translate("one by one"))
enable_merge:value("merge video and audio",translate("merge video and audio"))
enable_merge:value("merge video to picture",translate("merge video to picture"))
enable_merge:value("overlay in the middle",translate("overlay in the middle"))
enable_merge:value("custom overley",translate("custom overley"))
enable_merge.default = "left and right"
enable_merge.rempty  = true

picture_merge=s:taboption("video_setting", ListValue, "picture_merge", translate("merge video to picture"))
picture_merge:depends( "enable_merge", "merge video to picture" )
picture_merge:value("none")
picture_merge:value("one video and one picture",translate("one video and one picture"))
picture_merge:value("two videos and one picture",translate("two videos and one picture"))
picture_merge.default = "none"
picture_merge.rempty  = true

screen_input1 = s:taboption("video_setting", Value, "screen_input1", translate("The first file to be merged"))
screen_input1:depends( "screen_merge", "1" )
screen_input1.datatype = "string"
screen_input1.placeholder = "/mnt/sda1/input1.mp4"
screen_input1.default = "/mnt/sda1/input1.mp4"
screen_input1.rmempty = true

screen_input2 = s:taboption("video_setting", Value, "screen_input2", translate("The second file to be merged"))
screen_input2:depends( "screen_merge", "1" )
screen_input2.datatype = "string"
screen_input2.placeholder = "/mnt/sda1/input2.mp4"
screen_input2.default = "/mnt/sda1/input2.mp4"
screen_input2.rmempty = true

screen_picture = s:taboption("video_setting", Value, "screen_picture", translate("The picture file to be merged"))
screen_picture:depends( "enable_merge", "merge video to picture" )
screen_picture.datatype = "string"
screen_picture.placeholder = "/mnt/sda1/input.jpg"
screen_picture.default = "/mnt/sda1/input.jpg"
screen_picture.rmempty = true

picture_custom_1 = s:taboption("video_setting", Value, "picture_custom_1", translate("modify the screen resolution of input1 video"))
picture_custom_1:depends( "enable_merge", "merge video to picture" )
picture_custom_1.datatype = "string"
picture_custom_1.placeholder = "800:-1"
picture_custom_1.default = "800:-1"
picture_custom_1.rmempty = true
picture_custom_1.description = translate("800:-1 means: width 800, height adaptive correction")

picture_custom_2 = s:taboption("video_setting", Value, "picture_custom_2", translate("modify the screen resolution of input2 video"))
picture_custom_2:depends( "picture_merge", "two videos and one picture" )
picture_custom_2.datatype = "string"
picture_custom_2.placeholder = "320:-1"
picture_custom_2.default = "320:-1"
picture_custom_2.rmempty = true
picture_custom_2.description = translate("320:-1 means: width 320, height adaptive correction")

picture_custom_3 = s:taboption("video_setting", Value, "picture_custom_3", translate("vertex coordinates of superimposed input1 video"))
picture_custom_3:depends( "enable_merge", "merge video to picture" )
picture_custom_3.datatype = "string"
picture_custom_3.placeholder = "100:0"
picture_custom_3.default = "100:0"
picture_custom_3.rmempty = true
picture_custom_3.description = translate("100:0 means:the pixel at coordinates 100,0")

picture_custom_4 = s:taboption("video_setting", Value, "picture_custom_4", translate("vertex coordinates of superimposed input2 video"))
picture_custom_4:depends( "picture_merge", "two videos and one picture" )
picture_custom_4.datatype = "string"
picture_custom_4.placeholder = "120:20"
picture_custom_4.default = "120:20"
picture_custom_4.rmempty = true
picture_custom_4.description = translate("120:20 means:the pixel at coordinates 120,20")

video_custom_1 = s:taboption("video_setting", Value, "video_custom_1", translate("modify the screen resolution of input2 video"))
video_custom_1:depends( "enable_merge", "custom overley" )
video_custom_1.datatype = "string"
video_custom_1.placeholder = "320:-1"
video_custom_1.default = "320:-1"
video_custom_1.rmempty = true
video_custom_1.description = translate("320:-1 means: width 320, height adaptive correction")

video_custom_2 = s:taboption("video_setting", Value, "video_custom_2", translate("vertex coordinates of superimposed video"))
video_custom_2:depends( "enable_merge", "custom overley" )
video_custom_2.datatype = "string"
video_custom_2.placeholder = "20:20"
video_custom_2.default = "20:20"
video_custom_2.rmempty = true
video_custom_2.description = translate("20:20 means:the pixel at coordinates 20,20")

v_modify_duration=s:taboption("video_setting", ListValue, "v_modify_duration", translate("Modify duration"))
v_modify_duration.placeholder = "do not modify"
v_modify_duration:value("do not modify",translate("do not modify"))
v_modify_duration:value("specific time period",translate("specific time period"))
v_modify_duration:value("cut head and tail",translate("cut head and tail"))
v_modify_duration:value("only configure duration",translate("only configure duration"))
v_modify_duration.default = "do not modify"
v_modify_duration.rempty  = false

video_starttime=s:taboption("video_setting", Value, "video_starttime", translate("Start time"))
video_starttime:depends( "v_modify_duration", "specific time period" )
video_starttime.datatype = "string"
video_starttime.placeholder = "00:00:00.00"
video_starttime.default = "00:00:00.00"
video_starttime.rmempty = true

video_endtime=s:taboption("video_setting", Value, "video_endtime", translate("End time"))
video_endtime:depends( "v_modify_duration", "specific time period" )
video_endtime.datatype = "string"
video_endtime.placeholder = "00:01:30.00"
video_endtime.default = "00:01:30.00"
video_endtime.rmempty = true

video_headtime=s:taboption("video_setting", Value, "video_headtime", translate("cut head"))
video_headtime:depends( "v_modify_duration", "cut head and tail" )
video_headtime.datatype = "string"
video_headtime.placeholder = "15"
video_headtime.default = "15"
video_headtime.rmempty = true

video_tailtime=s:taboption("video_setting", Value, "video_tailtime", translate("cut tail"))
video_tailtime:depends( "v_modify_duration", "cut head and tail" )
video_tailtime.datatype = "string"
video_tailtime.placeholder = "10"
video_tailtime.default = "10"
video_tailtime.rmempty = true

vide_duration=s:taboption("video_setting", Value, "vide_duration", translate("only configure duration"))
vide_duration:depends( "v_modify_duration", "only configure duration" )
vide_duration.datatype = "string"
vide_duration.placeholder = "5"
vide_duration.default = "5"
vide_duration.rmempty = true

video_mute = s:taboption("video_setting", Flag, "video_mute", translate("Mute"))
video_mute.default = ""

video_picture = s:taboption("video_setting", Flag, "video_picture", translate("Save to picture"))
video_picture:depends({ video_x2645 ="none", picture_tovideo = "" })

video_frames = s:taboption("video_setting", Flag, "video_frames", translate("Set the number of frames"))
video_frames.default = ""

video_frames_num = s:taboption("video_setting", Value, "video_frames_num", translate("The number of frames"))
video_frames_num:depends( "video_frames", "1" )
video_frames_num.datatype = "range(1,25)"
video_frames_num.placeholder = "1"
video_frames_num.default = "1"
video_frames_num.rmempty = true

picture_tovideo = s:taboption("video_setting", Flag, "picture_tovideo", translate("picture to video"))
picture_tovideo:depends( "video_x2645", "none" )
picture_tovideo.default = ""

ptv_one=s:taboption("video_setting", Flag, "ptv_one", translate("only one picture"))
ptv_one:depends({ src_select ="one file", picture_tovideo = "1" })
ptv_one.default = ""

ptv_multi=s:taboption("video_setting", Flag, "ptv_multi", translate("multiple pictures"))
ptv_multi:depends({ src_select ="all files in the directory", picture_tovideo = "1" })
ptv_multi.default = ""

picture_resolution=s:taboption("video_setting", Value, "picture_resolution", translate("picture resolution"))
picture_resolution:depends( "picture_tovideo", "1" )
picture_resolution.datatype = "string"
picture_resolution.placeholder = "1280x720"
picture_resolution.default = "1280x720"
picture_resolution.rmempty = true

video_copy = s:taboption("video_setting", Flag, "video_copy", translate("Fast copy"))
video_copy:depends({ image_effects = "", video_x2645 = "none", video_picture = "", picture_tovideo = "" })

video_ready = s:taboption("video_setting", Flag, "video_ready", translate("Setup ready"))
video_ready.description = translate("Save/apply first please")

s:tab("action", translate("Action"))

audioaction = s:taboption("action", Button, "audioaction", translate("One-click Convert/Play/Output Audio"))
audioaction:depends( "audio_ready", "1" )
audioaction.rmempty = true
audioaction.inputstyle = "apply"
function audioaction.write(self, section)
	luci.util.exec("sh /usr/ffmpegtool/audioaction >/dev/null 2>&1 &")
end

audiostop = s:taboption("action", Button, "audiostop", translate("One-click STOP"))
audiostop:depends( "audio_ready", "1" )
audiostop.rmempty = true
audiostop.inputstyle = "apply"
function audiostop.write(self, section)
	luci.util.exec("kill -9 $(busybox ps | grep audioaction | grep -v grep | awk '{print$1}') >/dev/null 2>&1 ")
	luci.util.exec("kill $(busybox ps | grep ffmpeg | grep -v grep | awk '{print$1}') >/dev/null 2>&1 ")
	luci.util.exec("rm /tmp/ffmpeg.log 2>&1")
end

videoaction = s:taboption("action", Button, "videoaction", translate("One-click Convert/Play/Output Video"))
videoaction:depends( "video_ready", "1" )
videoaction.rmempty = true
videoaction.inputstyle = "apply"
function videoaction.write(self, section)
	luci.util.exec("sh /usr/ffmpegtool/videoaction >/dev/null 2>&1 &")
end

videostop = s:taboption("action", Button, "videostop", translate("One-click STOP"))
videostop:depends( "video_ready", "1" )
videostop.rmempty = true
videostop.inputstyle = "apply"
function videostop.write(self, section)
	luci.util.exec("kill -9 $(busybox ps | grep videoaction | grep -v grep | awk '{print$1}') >/dev/null 2>&1 ")
	luci.util.exec("kill $(busybox ps | grep ffmpeg | grep -v grep | awk '{print$1}') >/dev/null 2>&1 ")
	luci.util.exec("rm /tmp/ffmpeg.log 2>&1")
end

return m

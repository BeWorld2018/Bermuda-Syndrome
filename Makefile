
# List of possible defines :
# BERMUDA_WIN32  : enable windows directory browsing code
# BERMUDA_POSIX  : enable unix/posix directory browsing code
# BERMUDA_VORBIS : enable playback of digital soundtracks (22 khz mono .ogg files)

CC = ppc-morphos-gcc
CXX = ppc-morphos-g++

#DEFINES = -DBERMUDA_WIN32 -DBERMUDA_VORBIS
DEFINES = -DBERMUDA_POSIX -DBERMUDA_VORBIS -DBERMUDA_ZLIB
VORBIS_LIBS = 

SDL_CFLAGS = -noixemul -I/gg/usr/local/include/SDL2
SDL_LIBS =   -lSDL2_mixer -lSDL2  -L/gg/usr/local/lib -noixemul -lc  -lm 

CXXFLAGS = -O2 -Wall $(SDL_CFLAGS) $(DEFINES)

OBJDIR = obj

SRCS = avi_player.cpp bag.cpp decoder.cpp dialogue.cpp file.cpp fs.cpp game.cpp \
	main.cpp menu.cpp mixer_sdl.cpp mixer_soft.cpp opcodes.cpp parser_dlg.cpp parser_scn.cpp \
	random.cpp resource.cpp saveload.cpp screenshot.cpp staticres.cpp str.cpp systemstub_sdl.cpp \
	util.cpp win16.cpp

OBJS = $(SRCS:.cpp=.o)
DEPS = $(SRCS:.cpp=.d)

all: $(OBJDIR) bs

bs: $(addprefix $(OBJDIR)/, $(OBJS))
	$(CXX) $(LDFLAGS) -o $@ $^ $(SDL_LIBS) $(VORBIS_LIBS) 

$(OBJDIR):
	mkdir $(OBJDIR)

$(OBJDIR)/%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

clean:
	rm -f $(OBJDIR)/*.o $(OBJDIR)/*.d

-include $(addprefix $(OBJDIR)/, $(DEPS))

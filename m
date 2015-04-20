Return-Path: <alexander.haenel-baas@sieb-meyer.de>
From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
	<alexander.haenel-baas@sieb-meyer.de>
To: "Lucas De Marchi (lucas.de.marchi@gmail.com)" <lucas.de.marchi@gmail.com>
CC: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: modules out of tree issue
Date: Mon, 20 Apr 2015 09:09:36 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342963543@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-modules.vger.kernel.org>

Hi,
no idea what is going wrong, when i include the output path in obj-m variab=
le?=20

obj-m :=3D out/alex.o                                              <-- work=
s not under 3.18 but in older versions
out/alex-y :=3D internal/src/sm36502_uio.o=20

obj-m :=3D alex.o                                                       <--=
 works
alex-y :=3D internal/src/sm36502_uio.o

I found a diff in /scripts/Makefile.build=20

$(multi-used-m): FORCE                                             <- kerne=
l 3.18
$(multi-used-m) : %.o: $(multi-objs-m) FORCE <- kernel 3.17.8

I'm not sure but the dependencies are lost???=20

When I set $(multi-used-m): FORCE  to  $(multi-used-m) : %.o: $(multi-objs-=
m) FORCE in the 3.18/scripts/makefile.build, all my external modules make f=
iles are lucky.

I hope that helps to find out what is going wrong and we find a solution ho=
w I can use a outputdir in the obj-m variable.

---
Alexander=20

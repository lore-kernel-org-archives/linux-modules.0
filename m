Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Shea Levy <shea@shealevy.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, Nikolay Amiantov <ab@fmap.me>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: Improvements in search of kernel modules directory
References: <20160816005032.28881-1-ab@fmap.me>
	<CAKi4VA+3z3dqN89yazY2UJ40KmTAHzgW0UfiGfY3odbngqmj7A@mail.gmail.com>
	<8737i25za0.fsf@shlevy-laptop.i-did-not-set--mail-host-address--so-tickle-me>
Date: Wed, 07 Dec 2016 09:06:35 +0200
In-Reply-To: <8737i25za0.fsf@shlevy-laptop.i-did-not-set--mail-host-address--so-tickle-me>
	(Shea Levy's message of "Mon, 05 Dec 2016 07:35:51 -0500")
Message-ID: <xunylgvs2p6s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Shea!

>>>>> On Mon, 05 Dec 2016 07:35:51 -0500, Shea Levy  wrote:
 > Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
 >> 
 >> An environment variable for the library IMO is not a good option. If
 >> you take a look on how we separate the responsibility of each
 >> component you will see that we parse environment vars on the tools
 >> (e.g. modprobe) not on the library.
 >> 

 > Can you explain a bit why an environment variable is not OK here? The
 > code path using get_kernel_release is shared by many tools, and as
 > things currently stand there is already a global setting fixed in this
 > file. If we were to move this out to the tools, we would have to
 > duplicate this code in several places and any external tools linked
 > against kmod (e.g. systemd) will need to be updated as well. By default
 > users of this interface will not know that they need to check the env
 > var, because as things stand the code will just work, so it's likely
 > that new uses, in and out of kmod, will start out not respecting
 > MODULE_DIR and only after someone notices things aren't working for a
 > case relying on it will they be changed.

What worries me with the approach is increasing ambiguity and number of
points of syncronization.

I see kernel modules directory location as a part of shared state of
several parties, at least "make modules_install" of kbuild, module builders
like dkms, binary module packages, the kmod tools themself (this is
significant different to variables like LS_COLORS, which affect only the
current program run). Since the possible modules directories are mutually
exclusive (only one is taken in use), they must be somehow in sync, or I
expect some surprises for users, a-la:

- you install a module package, it has it's own idea about the directory
  (most probably hardcoded), but depmod from postinstall script doesn't
  generate working configuration (but doesn't fail as well most probably,
  since it's just working on a different directory);
- in general, result of an operation like "dpkg -i module.deb" depends of
  which user (with what environment) performs it;
...

Something similar about several directories. If we install some package
which installs modules (and creates the dir) into a directory which did not
exist and is checked earlier, then the old modules stop working without
very obvious (as for me) connection with the installed one.

The modules installation tools should be aware somehow about directory,
which is going to be used.

Since, as I mentioned, they are exclusive, there is no analogy with
variables like PATH, where all of the dirs are part of the configuration.

I'm not sure if the concerns are important in the real life.

-- 
WBR,
Yauheni Kaliuta

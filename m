Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,  linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] libkmod-signature: Fix crash when module signature is not present.
References: <20180308135810.4309-2-yauheni.kaliuta@redhat.com>
	<20180308181426.5617-1-msuchanek@suse.de>
	<xunyzi3d9gcw.fsf@redhat.com> <20180313105739.748518b6@naga.suse.cz>
Date: Tue, 13 Mar 2018 12:03:34 +0200
In-Reply-To: <20180313105739.748518b6@naga.suse.cz> ("Michal \=\?utf-8\?Q\?Suc\?\=
 \=\?utf-8\?Q\?h\=C3\=A1nek\=22's\?\=
	message of "Tue, 13 Mar 2018 10:57:39 +0100")
Message-ID: <xunyy3iw47ih.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-modules.vger.kernel.org>

Hi, Michal!

(Leaving in Cc only the list and maintainer)

>>>>> On Tue, 13 Mar 2018 10:57:39 +0100, Michal Suchánek  wrote:

 > On Mon, 12 Mar 2018 22:41:19 +0200
 > Yauheni Kaliuta <yauheni.kaliuta@redhat.com> wrote:

 >> Hi, Michal!
 >> 
 >> >>>>> On Thu,  8 Mar 2018 19:14:26 +0100, Michal Suchanek  wrote:  
 >> 
 >> > The mod_sig is allocated on stack and when no signature is present
 >> > it is not initialized and contains garbage. Later when freeing
 >> > mod_sig garbage pointer is dereferenced.  
 >> 
 >> I guess, it is enough to init the structure.

 > Yes, it is enough to initialize the structure. However, this issue is
 > caused by the awkward interface to the kmod_module_signature_info
 > function so changing the interface should prevent such errors in the
 > future.

Frankly, I made the same change of the interface in my initial
implementation before the functionality :) But it's up to Lucas, I guess,
you can send the patch on top of the master already now ready for
applying.

-- 
WBR,
Yauheni Kaliuta

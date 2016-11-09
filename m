Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, bjorn.andersson@linaro.org,
        afaerber@suse.de, lucas.de.marchi@gmail.com
Subject: Re: [PATCH v1 2/2] depmod: ignore related modules in depmod_report_cycles
References: <1478623550-18716-1-git-send-email-yousaf.kaukab@suse.com>
	<1478623550-18716-2-git-send-email-yousaf.kaukab@suse.com>
	<CAKi4VAKh0R-RN1j=Eum3wKtQ434D_7uBj1EGwzGCBrEB0qFkTg@mail.gmail.com>
	<xunyk2cdiciy.fsf@redhat.com> <1478683053.4155.8.camel@suse.com>
Date: Wed, 09 Nov 2016 13:23:40 +0200
In-Reply-To: <1478683053.4155.8.camel@suse.com> (Mian Yousaf Kaukab's message
	of "Wed, 09 Nov 2016 10:17:33 +0100")
Message-ID: <xuny7f8cj3r7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Mian!

>>>>> On Wed, 09 Nov 2016 10:17:33 +0100, Mian Yousaf Kaukab  wrote:
 > On Wed, 2016-11-09 at 04:59 +0200, Yauheni Kaliuta wrote:

[...]

 >> The problem is that the path is recorded "globally", not per vertex,
 >> and "wrong" mod6 is compared in "loop == m".

 > I agree and in the other thread Bjorn is mentioning kind of the same.

Ah, sorry, my bad: I just subscribed to the actual mailing list and Gmane
has the latest message from July.

-- 
WBR,
Yauheni Kaliuta

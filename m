Return-Path: <yousaf.kaukab@suse.com>
Message-ID: <1478683053.4155.8.camel@suse.com>
Subject: Re: [PATCH v1 2/2] depmod: ignore related modules in
 depmod_report_cycles
From: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, linux-modules
	 <linux-modules@vger.kernel.org>
Cc: bjorn.andersson@linaro.org, afaerber@suse.de, lucas.de.marchi@gmail.com
Date: Wed, 09 Nov 2016 10:17:33 +0100
In-Reply-To: <xunyk2cdiciy.fsf@redhat.com>
References: <1478623550-18716-1-git-send-email-yousaf.kaukab@suse.com>
	 <1478623550-18716-2-git-send-email-yousaf.kaukab@suse.com>
	 <CAKi4VAKh0R-RN1j=Eum3wKtQ434D_7uBj1EGwzGCBrEB0qFkTg@mail.gmail.com>
	 <xunyk2cdiciy.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-modules.vger.kernel.org>

On Wed, 2016-11-09 at 04:59 +0200, Yauheni Kaliuta wrote:
> Hi!
> 
> It may require more serious refactoring, since there is a problem
> with the
> approach of path recording. I can get wrong output, for example, for
> the
> following graph:
> 
> /*
>   mod6 -> mod7 -> mod8 -> mod9
>    ^               |       |
>     ---------------        |
>    |                       |
>     -----------------------
> */
> 
> depmod: ERROR: Cycle detected: mod7 -> mod8 -> mod9 -> mod6 -> mod7
> depmod: ERROR: Cycle detected: mod6 -> mod6
> depmod: ERROR: Found 5 modules in dependency cycles!
> 
> 
> The problem is that the path is recorded "globally", not per vertex,
> and
> "wrong" mod6 is compared in "loop == m".

I agree and in the other thread Bjorn is mentioning kind of the same.

BR,
Yousaf

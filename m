Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:44121 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab3KKT2l (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 11 Nov 2013 14:28:41 -0500
Received: by mail-vb0-f48.google.com with SMTP id m10so1118675vbh.7
        for <linux-modules@vger.kernel.org>; Mon, 11 Nov 2013 11:28:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <509C4944.3040907@redhat.com>
References: <509C4944.3040907@redhat.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 11 Nov 2013 17:28:20 -0200
Message-ID: <CAMOw1v6xtqE4yTt4CBJ0fZP_wan2EOuPD8052L6Y_RU4g62agg@mail.gmail.com>
Subject: Re: [announce] python-kmod 0.9
To: Andy Grover <agrover@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, wking@tremily.us
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, Nov 8, 2012 at 10:07 PM, Andy Grover <agrover@redhat.com> wrote:
> Hi all,
>
> I'd like to announce python-kmod 0.9. It is available here:
>
> https://github.com/agrover/python-kmod
> git://github.com/agrover/python-kmod.git
> https://github.com/downloads/agrover/python-kmod/python-kmod-0.9.tar.gz
>
> A gentleman named W. Trevor King basically rewrote it from the ground up
> using Cython, a language that bridges the gap between C and Python.
> These changes make python-kmod Python 3 compatible, as well as enabling
> the Python API to fully express libkmod's featureset.
>
> Anyways, this was a big change, so I wanted to announce it. :)
>
> Regards -- Andy
>
> p.s. btw I've worked on some other libs where core devs wanted to pull
> in Python bindings to their tree. Not asking for this, but not opposed,
> if desired. :) -a

Hey. I think I replied once that this could be better left off in its
own repository. However I'm reconsidering this now... if you are still
interested in merging into kmod, I think it would be good.


Regards,

Lucas De Marchi

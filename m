Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4EFD92AF.7000402@suse.cz>
Date: Fri, 30 Dec 2011 11:30:07 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: add target to install gzipped modules
References: <1325173819-26274-1-git-send-email-lucas.demarchi@profusion.mobi> <4EFC9872.7000708@suse.cz> <CAMOw1v6GhA+B2oXcVK4YZULb6kq=-NFTv-=-4eYB0ukZ9acP-w@mail.gmail.com>
In-Reply-To: <CAMOw1v6GhA+B2oXcVK4YZULb6kq=-NFTv-=-4eYB0ukZ9acP-w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 29.12.2011 18:35, Lucas De Marchi wrote:
> The operation that is used most of the time is to load modules. The
> reason for having modules gzipped is the same one as for kernel image:

The reason for having the kernel compressed is that the x86 bootloader
reads the kernel (and initrd) using bios calls. That's not the case for
modules.

Michal

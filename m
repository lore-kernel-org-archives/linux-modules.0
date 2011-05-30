Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4DE3AF93.40405@suse.cz>
Date: Mon, 30 May 2011 16:54:11 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Jon Masters <jcm@redhat.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] depmod: Handle X.Y kernel versions
References: <1306763923-11892-1-git-send-email-mmarek@suse.cz> <BANLkTinU9DoY4gUXK2kaoUiNvbG905-ngQ@mail.gmail.com>
In-Reply-To: <BANLkTinU9DoY4gUXK2kaoUiNvbG905-ngQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 30.5.2011 16:43, Kay Sievers wrote:
> On Mon, May 30, 2011 at 15:58, Michal Marek<mmarek@suse.cz>  wrote:
>> What a stupid check.
>
> Maybe get rid of the entire check?

Why not. It tries to distinguish between
depmod da.da.da (kernel version)
and
depmod /path/to/module.ko ... (only generate tables for listed modules)

Either we can check for slashes in the second use case, or just drop 
support for it.

Michal

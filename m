Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4DE4AFD6.4000403@suse.cz>
Date: Tue, 31 May 2011 11:07:34 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Jon Masters <jcm@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] depmod: Handle X.Y kernel versions
References: <1306763923-11892-1-git-send-email-mmarek@suse.cz>
In-Reply-To: <1306763923-11892-1-git-send-email-mmarek@suse.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 30.5.2011 15:58, Michal Marek wrote:
> Linus, I'm affraid this ruins the plan for Linux 3.0. Except if you want
> to force users to upgrade module-init-tools, with the excuse that 3.0
> is a huge step forward and breakage has to be expected ;-).

For reference, http://marc.info/?l=linux-kernel&m=130676710124446&w=2 
has a workaround, so 3.0 should work even with older m-i-t.

Michal

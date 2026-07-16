Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E641A543;
	Thu, 16 Jul 2026 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201533; cv=none; b=YiP5wEukwCOnNZRypdIU2g+00uBSgQrokrKNuDl1dFrzNfm4wbwukxp6cIxv5aZ8aby1yh3hWP0SPFMgVkrRRRwrhgwXhxT/SZVx0VzewCvJB5jeDdkpvEUf695twFy75Ljg2XPQy03kuAQwg6Ta+rFW/WarPnbr4iOK+2sGM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201533; c=relaxed/simple;
	bh=Trz811rFu66hjh5PpSzoKZHnybwWvPe1KbzVP++vxWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5XjvdcVV/uTYzNq5aP+xtVIaQ24RaFIzLQaCW/1BEnJ5WNEMpmS3bND8Ltt5T+UEXXaLwPfZJVbf5Dj5tXKO3d/eGf4iQgu8R3Qr69KVW7oFq2EqBckQSZI1/XD5+QQMZ04wD+q0j7rYIT6DDgk+OmlZcCQB+qtGLSEfYcCp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8LD+AjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8LD+AjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3432B1F000E9;
	Thu, 16 Jul 2026 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784201532;
	bh=FMlVj/7YoKPmap5SOctpNnUocp1sDIMWHSXFoQ3DJ0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q8LD+AjHX9wLIW1+g4foVEe6EPDVgeAI9/mu1UPl00HKqye1EriRck3p8y31w3FTX
	 qyCOVTHGnjvi4z1uXBZDED/2bnU7jaRmjVO1nV+3PLpoAphfIM1yFxedv1XWScwwX5
	 iyy7PjHO0yKRvMhiPJ9CRGV6ji7dSnQs5v6GP/rj12eThB/DwTvsMgVMgAVR84tN3M
	 Sw2tQKVUZ2RwMQSlxJ2K8pQHj8yl+9iKKW1o/rEXg7D1AK+u2Ho7ce2Ln6p70r5Aw2
	 iAdpaatcjLBKdMVMIeh4rf+MyKYGslybmdG7uaQIO6C42HEGyfeu5rrdD00rg9f2Oy
	 ilaUSbdNzxYZA==
Date: Thu, 16 Jul 2026 07:32:11 -0400
From: Sasha Levin <sashal@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Richard Weinberger <richard@nod.at>,
	Juergen Gross <jgross@suse.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Vlastimil Babka <vbabka@kernel.org>, Helge Deller <deller@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 0/4] kallsyms: embed source file:line info in kernel
 stack traces
Message-ID: <aljBOy_fIepzRqmY@laps>
References: <20260709163833.3851179-1-sashal@kernel.org>
 <CAMuHMdUCAX642tSJhvG_Ku6Y=D8GK3owbyed9qkhzPpgrU1kdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUCAX642tSJhvG_Ku6Y=D8GK3owbyed9qkhzPpgrU1kdg@mail.gmail.com>

On Fri, Jul 10, 2026 at 12:04:56PM +0200, Geert Uytterhoeven wrote:
>Hi Sasha,
>
>On Thu, 9 Jul 2026 at 18:38, Sasha Levin <sashal@kernel.org> wrote:
>> Changes since v6
>> ================
>>
>> - Address Sashiko AI review comments.
>
>What does that mean?
>Please list the changes, so reviewers know what to look at.
>Thanks!

Sorry! I've missed your mail.

There were a few smaller changes, mostly on the kunit tests side, here it is:

   - Bound lineinfo lookups to the resolved symbol's start so it stops stale annotations on __init code and __pfx_* padding
   - gen_lineinfo: handle SHT_REL .rel.debug_line (i386/arm32 modules)
   - gen_lineinfo: bias all exec sections, drop foreign DWARF sequences; cover .noinstr.text (kvm.ko)
   - __aligned(8) + static_asserts on the blob structs — fixes 32-bit layout mismatch (i386/m68k)
   - SLEB128 decoder: do the shift unsigned
   - KUnit: skip instead of fail when =m without KALLSYMS_LINEINFO_MODULES
   - KUnit: dereference_function_descriptor() for target addresses (ppc64 ELFv1/parisc)
   - KUnit: volatile accumulator in lineinfo_target_many_lines() (compilers fold it otherwise)
   - KUnit: OPTIMIZER_HIDE_VAR for the mid-function address — fixes objtool !ENDBR warning
   - KUnit: new regression tests (init-text stale annotation, 5-byte SLEB128 decode)

-- 
Thanks,
Sasha

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.42.244.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600604;
	b=AyVDzcFaDEbPohtIppnjEXRKOOEE6L1COHGLoJZAbQf3j858Dax/o02nClj/IkJ+bsI6
	 78DQGWOih5fShb/t1suC3h/iq45+mbucQqhQfpbmec0Eh4JelBw4t6NA3mK21L+0tPKW4
	 JarMpwGh7/cmqStH97KMIJ6gszFLQPVf6se56UFbpix1ymf0caeqxGyg6RWxTUiaQKJp1
	 ZN4zOuJhjm96viBpLTyPYlw8gkUshHfKtaRp0Ga7lvl1ogyFxw/OvuzpPcuNNlRpqLF8x
	 uSZ2xRamxFPRGO+OM9tlTpL+tXiynXzjilZkxfXhCEenAuMJ/paTFPT7DVQsKaOAIcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600604;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization:x-ms-reactions:
	 X-purgate-ID:X-purgate-type:X-purgate-size:X-Notice:X-purgate:
	 X-purgate:X-pfmilter;
	bh=o9V35QWmnxkcGDaXqhjxiPIy0R24gUWruywCyvkZf9g=;
	b=m50LyulA/iCwMBAodkD9bXvCZ/Iiwn9pOyk+sv040VDQ2yBIXJHZ0CZqULi1jOD9hmHv
	 NzVh4nuaS8ijzzd3FKmHF2Be8UpGL5fqMyj6ALkSMM2KXX6MmJK6ETIriF+O+EnVeuqCQ
	 QbZo0WQzPpXXc094oe2C/wOvMsmVPUb6lWYEpS0Hj9eyYrV/s8/g6Qx/3uSR2T9RFdsQB
	 goSbqmUBl9u78kRordGfuc3NekPppNAqEUgfZav+IBrmvt24wVlf/4QDyE/Nzt3q0O6CJ
	 h+HP+vj+C6wCYGs366xJjsnWFYrwFObk5I/JDDzL1JcxK/iLKjaujfSI6NYpLt0K2Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fritz.com;
	spf=pass smtp.mailfrom=fritz.com;
	dkim=pass header.d=fritz.com header.i=@fritz.com header.a=rsa-sha256 header.s=mail header.b=OvOVK9ai;
	arc=none smtp.remote-ip=212.42.244.120
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBF606A329;
	Wed, 25 Nov 2026 09:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10EBF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.a=rsa-sha256 header.s=mail header.b=OvOVK9ai
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1795600592; bh=pZNseUamYF/NcBCWp2XFZ917wokQkwCmyXEupzEFfo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvOVK9aiHm8AT8ElIOf0mHmcxUZqwvb9/Usx9TkHvu+FLOLBysBfDif3qHokFDPEe
	 nlzMytPtB80W+7JR1u9lNTK7rMmuJQhpwqyTN6A7oifJLbZbukMFQuMWk/alMlt7Vz
	 709n2l4yfmtdMnlpyL7Sz1aW77eKlBu86HvbUzwnDQs5u30YYG/+tvXeEs95Gk8Mk2
	 Vm9cM/0CQj/vpLQiMGoal3nPkHzq25SNIMrakcmlahLSPSgMUAH7pa87hTS7S6j619
	 S5FDwDQnzFvw0BuXbAIJFVQnuzcNaxH+3WwOWAwuMk038+czYJ0r/x5Bpu8bwCAXQe
	 cYRcdz8PZrcSg==
Received: from [212.42.244.78] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <n.schier@fritz.com>)
	id 6b06b0d0-045b-7f0000032729-7f000001912c-1
	for <multiple-recipients>; Wed, 25 Nov 2026 10:56:32 +0100
Received: from mail-auth.fritz.com (unknown [212.42.244.78])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 25 Nov 2026 10:56:32 +0100 (CET)
Date: Wed, 25 Nov 2026 10:56:32 +0100
From: Nicolas Schier <n.schier@fritz.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
	Kees Cook <kees@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v6 5/7] kbuild: batch module finalisation
Message-ID: <20261125-bald-mushroom-of-development-7b2288@l-nschier-z2>
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
 <20261124-build-speedup-v6-5-141a4f861c67@kernel.org>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261124-build-speedup-v6-5-141a4f861c67@kernel.org>
Organization: FRITZ! Technology GmbH
x-ms-reactions: disallow
X-purgate-ID: 149429::1795600592-22FEB977-6F71B524/0/0
X-purgate-type: clean
X-purgate-size: 4480
X-Notice: Whitelisted
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-01  mail-id: D1F4DA0233  external: no

On Tue, Nov 24, 2026 at 12:20:15PM +0000, Lorenzo Stoakes (ARM) wrote:
> With the .mod.S change in place, module finalisation on allmodconfig builds
> consists of a large number of very short-lived jobs.
> 
> For allmodconfig x86-64 this can be on the order of ~22,000 jobs of a few
> milliseconds in duration each.
> 
> Each job entails processing ~22k .cmd files, so the combination of heavy
> overhead and small individual job results in a lot of unnecessary and
> repeated work even with all cores being utilised.
> 
> The solution is to batch by a number of jobs. Determining which value makes
> sense was done empirically.
> 
> On a 128-thread threadripper box doing an allmodconfig build, best of
> 2, *.ko, *.mod.o deleted each time:
> 
>     modules per chunk    instances    wall
>     -----------------    ---------    ------
>                     1        11171    10.22s
>                     2         5586     6.72s
>                     4         2793     4.97s
>                     8         1397     4.26s
>                    16          699     4.05s
>                    32          350     4.05s
>                    64          175     4.07s
>                   128           88     4.05s
>                   256           44     4.03s
>                   512           22     4.18s
> 
> Wall time flattens for 16-256 module batches.
> 
> A slower/lower core machine will do better with fewer modules-per-batch, a
> faster/higher core machine will do better with more modules-per-batch.
> 
> Therefore, take the midpoint which works in the most margin in either
> direction - 128 modules per batch.
> 
> This naturally scales with module count too as the optimum gains are
> obtained with higher module count, so fewer batches in this case costs less
> overhead.
> 
> Each instance holds only its own modules' variables and the top-level one
> reads no per-module .cmd files at all, the same rules serve both levels,
> and an instance is told its chunk with modfinal-first=<index>.
> 
> Only the top-level instance builds .module-common.o, to the chunks it is a
> plain prerequisite, so no two instances ever write it.
> 
> "make modules" with every *.mod.o and *.ko deleted goes from 28.9s to 15.9s
> with clang 22. No-op "make modules" goes from 5.6s to 4.8s, as checking the
> 22,000 targets is spread over the chunks too.
> 
> Whole build, 128-thread Threadripper 9980X, best of N runs:
> 
>                                          before   after     delta
>                                          -------------------------------
>   x86 allmodconfig, no-op make, gcc         2.3s     1.4s    -0.85s (-38%)
>   x86 allmodconfig, no-op make, clang       2.8s     1.8s    -0.94s (-34%)
>   x86 allmodconfig, clean, gcc            306.6s   294.1s     -12.6s (-4%)
>   x86 allmodconfig, clean, clang          290.2s   283.9s     -6.4s (-2%)
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  scripts/Makefile.modfinal | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 75e9effdf02c..4d5e6e1a0ff9 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -13,9 +13,30 @@ include $(srctree)/scripts/Makefile.lib
>  # find all modules listed in modules.order
>  modules := $(call read-file, modules.order)
>  
> +modfinal-chunk-size := 128
> +
> +ifdef modfinal-first
> +
> +# this instance handles the chunk of modules.order starting at $(modfinal-first)
> +modules := $(wordlist $(modfinal-first), $(words $(modules)), $(modules))
> +modules := $(wordlist 1, $(modfinal-chunk-size), $(modules))
> +
>  __modfinal: $(modules:%.o=%.ko)
>  	@:
>  
> +else
> +
> +modfinal-chunks := $(addprefix chunk-, $(shell seq 1 $(modfinal-chunk-size) $(words $(modules))))
> +
> +PHONY += $(modfinal-chunks)
> +$(modfinal-chunks): .module-common.o
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal modfinal-first=$(@:chunk-%=%)

Thanks!

Reviewed-by: Nicolas Schier <n.schier@fritz.com>


(bike-shedding) For readability, I'd favourised the use of pattern 
matching stem:

$(modfinal-chunks): chunk-%: .module-common.o
	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal modfinal-first=$*

-- 
Nicolas

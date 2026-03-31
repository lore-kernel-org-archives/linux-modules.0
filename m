Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48087423A7A
	for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971353; cv=none; b=lw+PE2oi1fGzA5aLYUCrT6BqHQruzUrKIfSLEIW1gr4HWm5eOvQnNPzQy1wigvU/nZwEJmklvrf9sRtritvXydfyRksAFdGup1AXju3Of8EsPoAaLEnvs3cu0eqv/vLZKKBj4Wsohh0SLai81Nvybz6edFDCBI2U50AEiCFBLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971353; c=relaxed/simple;
	bh=0WFog79zuDRJhn/p/fsZHmfoespawcmgR5YmcyH0GY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDIfA3LuHAIyJJUiRUBghpkNOS9+G6YX2Gm2BQB5ukpgxtPai9rbHu8Rtf/XOdjSZZMMkfe2YlIkc98WDkyzddL1zacv2o9Padkgod7Fpc/i73+TNJy3z69hnPRVrBMnYGcZcSASxW8iyJHbc55wLwc/fkr3CT4zDNB6RjuVB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K5C8Xa1K; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K5C8Xa1K"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b87970468so5181997f8f.3
        for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774971348; x=1775576148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MiGvSf1cEKquv9AHWJHz+IKC+VcqOToPMsbHXtYmwWU=;
        b=K5C8Xa1KWejcZCUQIt3T0/O+JBPN3KCcwDpAMoU6ePRO1ZKXzOYVJHG8p7aoJAFIx0
         QFS6XToNcQtKJYlJdiPfxW6OFwoJFN2425pIorPD90+33JpuCEMhj3R/RLyz6ur5x2e8
         X1GUbm9wdnqc1ND/tD7mXvRi50mTjc2BUA6TGVVW905yRP8g40fSEjG7iidOv70JJCEM
         Ajr2cOz5rq+aaLf191KENgQZr27ouVCYl5ZEadY8LZZkmmDrAsVlb8VTDz8/g07x19y6
         3A+aBKdcCvhaluS69CrdQoPut/CPs+49FOlv9Hl2KN0IVjadfUaDWoQtfr98ONQ3l9En
         ttRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971348; x=1775576148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiGvSf1cEKquv9AHWJHz+IKC+VcqOToPMsbHXtYmwWU=;
        b=BdqK/f+i88EQwf30G/PGhF9vDcsOwya6Txk0xojLW9jmmAhi6E1f1kbIc+ZgiYJdsB
         qopxK9Vyv4qmby25AWtxi/GrRa38wShtZW/qpGOMk2eOMMTbf4hVHf4HM6pzE7sunJks
         IZ0q3IL9nJ51AKS3whaewhS/FJTOzfTjA+vJYg2JA4OORdVqMIMWiqkh0nMsEdHDOcdX
         cYCd22YXvgP0pqjZqnRuXnXmrCv1GmyGBTyWekKopwvdlRqRXIpv6SxBjOnHffKUOSI2
         7Rg/6vdg+AXYm+1V/feeffIZ7Vvepg2G1QC5Ci8vur2o6Hbltvt/O6aSmEuw2j+0xzIb
         SP/w==
X-Forwarded-Encrypted: i=1; AJvYcCVmy9Gkh3tNpHU+3PdI3+nquVAAxQ+yCsEwevZhqyVr9t5tFg/25HfC/ZgnV7g0PIyGqMnyDFsXp2lYu3Ah@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSS32vplgl3CV9PUceo+ymfr688Qk/52GeAIHbdCzhGra5f+I
	vhQKws+M9fqNmgi07E7rsOo8R0fbBOl7FIUEowKIhVIu2aBNdIlgBykHIZuiob+z5x8=
X-Gm-Gg: ATEYQzzw3u1+npf5hyQWVbw+79mLBLAjZd2+lYD3mOCVsazF/X3qJFsjh9PJ93HnH3n
	aD3LBXRcOw6Az4huX7w0buIiR3QiyjbEpwo6nrPfiD9Fn/+HBDBRkdTOjBLGLO+imYOQu1iVbI5
	7bTmxpsftMvVvgALein6pozE9tXaVsUgQmFAxqo7CVn0IJzGuLgzp4heB6F5VnhV7QpPIxvMw0Z
	7z+Rlxr2PpOn5IF7k+X2LNSE0Rbq2rK9q+YooPfKbcxWbR4bjZvlPDex1Igycw+vToZ5MxfH8EG
	3p8avdVEpBiG/6QeLu+d4Cnr96moysy+B/DWKp9DDHnsSOFi3Z+f2ciMN4kht/lGtfeKVy07s93
	NcnncmN0DIDS8RIYscKWClaZGKnso1HZfLBxi3Ba5GHKu7fMFaeki6PD4USrTDyeWMCkT1HkrHy
	WlILlDeOEmBPvxdYM1LM7W19fIOg==
X-Received: by 2002:a05:6000:4211:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-43d1507620bmr185363f8f.14.1774971348197;
        Tue, 31 Mar 2026 08:35:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf90424fcsm23487555f8f.32.2026.03.31.08.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:35:47 -0700 (PDT)
Date: Tue, 31 Mar 2026 17:35:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init.h: discard exitcall symbols early
Message-ID: <acvp0HFv3o_i9sa3@pathway.suse.cz>
References: <20260331142846.3187706-1-arnd@kernel.org>
 <acvghO4glmZamFSZ@pathway.suse.cz>
 <82bc9a6f-2184-41fa-af8a-5cf50ac04f44@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82bc9a6f-2184-41fa-af8a-5cf50ac04f44@app.fastmail.com>

On Tue 2026-03-31 17:01:20, Arnd Bergmann wrote:
> On Tue, Mar 31, 2026, at 16:56, Petr Mladek wrote:
> > Adding module loader maintainers into Cc to make them aware of this
> > change.
> >
> > On Tue 2026-03-31 16:28:38, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> Any __exitcall() and built-in module_exit() handler is marked as __used,
> >> which leads to the code being included in the object file and later
> >> discarded at link time.
> >
> > Is this safe for dynamically loaded modules?
> >
> > Honestly, I am not sure what is the exact efect of this change.
> > The dynamically loadded modules just came to my mind...
> 
> In a loadable module, using __exitcall() directly already discards
> the function at link time, so there is no difference from built-in
> code. Actually using __exitcall() here is a mistake regardless
> of my patch.
> 
> Using module_exit() in a loadable module still behaves as before,
> this uses a different macro, which already has __maybe_unused:
> 
> #define module_exit(exitfn)                                     \
>         static inline exitcall_t __maybe_unused __exittest(void)                \
>         { return exitfn; }                                      \
>         void cleanup_module(void) __copy(exitfn)                \
>                 __attribute__((alias(#exitfn)));                \
>         ___ADDRESSABLE(cleanup_module, __exitdata);
> 
> so this is also unchanged.

I see, I was confused because cscope pointed me to:

/**
 * module_exit() - driver exit entry point
 * @x: function to be run when driver is removed
 *
 * module_exit() will wrap the driver clean-up code
 * with cleanup_module() when used with rmmod when
 * the driver is a module.  If the driver is statically
 * compiled into the kernel, module_exit() has no effect.
 * There can only be one per module.
 */
#define module_exit(x)	__exitcall(x);

and I missed that it was the variant for the built-in modules.

Best Regards,
Petr

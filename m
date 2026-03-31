Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7536BCCC
	for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968972; cv=none; b=VMskR/wjeqJJi1ueAG6Zqf5mY+UkTjmL7Z/+kFuVor3GN5/iUsWtWYTbG+CBuSKYh7tSMJMeAZXrKrL5rxYt/nPhW1TUYlLiCEFQqaRxb480GpAcZ4hqFFZ1zdpoY+W7lrTwaoSC7k2/s1dsv24GL5GWAmGK8bg30TKplqjICC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968972; c=relaxed/simple;
	bh=jKxaM8XS+QGoasE5LVre1ULC0QIBA1mU1HIQ8CMnbPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDTAf6uG4Lv99PH0hJw9NJI3usr2QHOFVKqR2Y//GFtm6yq/S7CH4KSg48o2qVKPlNyeLhu0BZENX5DLgWMjOD5UlkBofMw7rD/eP3J/px4VDtX7LXriEcBiBra5dqM7h+axwa9Ez/epsNh4tWKSqTBvJji70IKRKWer5hPOFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ja6qDZVD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ja6qDZVD"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so1885301f8f.3
        for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774968970; x=1775573770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOWUdy++pUefUEURVk9zZcOvlfK+YwiTNt/ou4gudNE=;
        b=Ja6qDZVDy0h/sUo6hcIdYSLoQmmKtNcVxEGyPGUA6v8KdsyMaTbRvRGvNceBj+Y8gd
         IDZ0LrrZpzJd0aN/rtuU6YcdKfRzjxAufGPR/Y+FfInty758n3UvwMNwV+UTisn1OgVw
         6VgagNOntG+VlIHBKByO+p7axUoImoEEHqfFPzGxNQ1AJLi7Z8gXzfNbwYjMP14RNAsW
         wcwqJPp+kNK3CELbzKKxjA0UyW7IP2O8ohkUsyLmQzUOjOl4UKU2VW8QWjlRp6qQIrUT
         nZ89/xuIQ/WfFRR168GH7MXgIb3KiEo7N1q6HUIIZD1+91za91We4vnWFx8PFRYGR30R
         oQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774968970; x=1775573770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOWUdy++pUefUEURVk9zZcOvlfK+YwiTNt/ou4gudNE=;
        b=ZP01W8GhrezK55rs6vvypTKN9CcRL9SdHPTVr7e/VtaCOZrD/4vSQIc2ExSdoqdpo4
         7HUdOPfeZuzMzdqV/wLl+Lw6UqI7HnAU+SjI84bEySHHUmuAUl8LemYLNujtsVWIXxjN
         kIxanuxCtJtIppYh2Wh/VxrZtMnAztphb89r4jymdcd/fFrykRlQBNYYhfdghOwcp54i
         Kpy1HTpsg+G9HZqo2glMtJ+FskEvKy00ZAS54T1BiH0RtuIr1o4PK3BTrRkSRLnTeSOK
         iXJWX4MfEW751Fv3F8y9pN1vJ83zY3VRtA857NZ45s9zWrxM/ef4sTZQ7uzGjhSQ5Ql7
         pYSA==
X-Forwarded-Encrypted: i=1; AJvYcCWosjV5EshYX8NUoFBGCRszABz03qrW2HbqM+gsoWW3hT2H48BrYkXSX56jSurnDr271sfZhK4P5ZyJRhYD@vger.kernel.org
X-Gm-Message-State: AOJu0YzJEFoDQBlI36a1mfuSfqfS72g7f05Vjws69OT9rmIVfkM6D3UD
	fDq/7Fd6RsPsYcvRf6G35kBsF+Cwq7f+g7fhrGjPtu42eYrm1on/sIVn4gN0glgXfKE=
X-Gm-Gg: ATEYQzy7sb1MVxC1J0K/SJ1cOAREZn/DlevgXpuiwksj7f4pOYGs899PW+TsqpIl9rb
	faIlVm4xuNCudjTZCFn0DnF4EYrp/ku4TSSPMMO+OlFnozrPne8JRARxKGq+VkbqR0A8inMp8sj
	Gx8G90MK/5EbCqpz6DNnObXGv3/C2WU8+DY37TAjB8zq+TIHMxYDd+Wh/DRc+KvwT2pV+xFniaC
	vlx/CnvL3yWLHbpQ8TwPc3etg8V9yjDsOHB4OrJPmGQPm2eSgUYtXpr2dRx8o8q3ONo61gj06UB
	yMAYwwLm9fcWGeCwsRqgyulUkcbs1nm5IGqpl4nBCGQsDZX2X+3vya8IVJ1abCWkmRzrtL7aeRh
	Xf1JV2D24mXhjFm0kG6mANl0qjiz/IqHCYWTC8isr3aKNbrXxPPPCFkZL2c1EsTUj4oYZR8QI89
	X7oHFR8/6LI/cNJunD52Eg6+zHEA==
X-Received: by 2002:a05:6000:2dc9:b0:43b:490a:db51 with SMTP id ffacd0b85a97d-43b9e9fb32cmr29895659f8f.24.1774968966934;
        Tue, 31 Mar 2026 07:56:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d14c53928sm336419f8f.5.2026.03.31.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:56:06 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:56:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init.h: discard exitcall symbols early
Message-ID: <acvghO4glmZamFSZ@pathway.suse.cz>
References: <20260331142846.3187706-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331142846.3187706-1-arnd@kernel.org>

Adding module loader maintainers into Cc to make them aware of this
change.

On Tue 2026-03-31 16:28:38, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Any __exitcall() and built-in module_exit() handler is marked as __used,
> which leads to the code being included in the object file and later
> discarded at link time.

Is this safe for dynamically loaded modules?

Honestly, I am not sure what is the exact efect of this change.
The dynamically loadded modules just came to my mind...

Best Regards,
Petr

> As far as I can tell, this was originally added at the same time
> as initcalls were marked the same way, to prevent them from getting
> dropped with gcc-3.4, but it was never actaully necessary to keep exit
> functions around.
> 
> Mark them as __maybe_unused instead, which lets the compiler treat
> the exitcalls as entirely unused, and make better decisions about
> dropping specializing static functions called from these.
> 
> Link: https://lore.kernel.org/all/acruxMNdnUlyRHiy@google.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/init.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 5db55c660124..ad5c19763034 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -47,7 +47,7 @@
>  #define __initdata	__section(".init.data")
>  #define __initconst	__section(".init.rodata")
>  #define __exitdata	__section(".exit.data")
> -#define __exit_call	__used __section(".exitcall.exit")
> +#define __exit_call	__maybe_unused __section(".exitcall.exit")
>  
>  /*
>   * modpost check for section mismatches during the kernel build.
> -- 
> 2.39.5

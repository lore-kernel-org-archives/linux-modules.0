Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E721D59C
	for <linux-modules@vger.kernel.org>; Wed, 17 Dec 2025 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765932733; cv=none; b=fsRDsWHVdP3/bw2KMn2cuQic+14wHWW7+hCw8Q5N9AM8quzdH3nhbrHSEJ7KDUxLahAXflQqa9VmGG/gHA+jmkDsGSRPmkUGVP9VYWN7OM1dJLJ5dl4/HlXnb3cKRIvSWMG/Age3a0ZWXVHGq+IoXt61gs+YCmYxkr2mndJK0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765932733; c=relaxed/simple;
	bh=6enibQ1KiY6/mBYId/dIKMBTFex0cy8o4uX0luFTpxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNH3ojX0Y32gXp44w9nBIjJDDkd9548NmqbTIHsc7b9A6i+Jxp2uIFATBp0lMjtPbyHHiJKLvshVyq8UR62lfYQrhKIYU9A5UwRQYnzmMCYb5G3MxIusSuQloQgXIwMfiQe5VoHQZ8hdd9UDsnlM+d2+rHSktj1r/6uFAcN5AEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMSDDE0L; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMSDDE0L"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64467071f9fso4230331d50.0
        for <linux-modules@vger.kernel.org>; Tue, 16 Dec 2025 16:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765932731; x=1766537531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cioc2n+rnrE7Hz/WlxOPFl1U+rBoRANXF/y2Cvvc8mg=;
        b=BMSDDE0LBQrAGNhxtY2eF/vy8+GasbV7v00/A+VidSsjvKlqyiZP0lMSwOcCLfNOEt
         M/ozA68B2EiVwTCYgxQwKaVeYlJxnDQHpJOF/ZxYrVV1/IBfbnfDDDgpLpMhAelKn+lU
         G/I+rxeEISrkJmYJBJRX0AYH5IFw6+aJ7+BkALX40Yy2ZoaNlHMhT5Nr5cN4aHSgloyZ
         hBrq0n8Lcxc7irCqOmQcIOKPjn6D7+I++DuyXYKusYzPiI3SJmuYNKseAm6hNZPmAofc
         QrFn/HComCiWMZta4UT2u4wDdufxYX4zAir9LV/SmdsRvEAqjihgUyAcpq4nLBSy3z6R
         /kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765932731; x=1766537531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cioc2n+rnrE7Hz/WlxOPFl1U+rBoRANXF/y2Cvvc8mg=;
        b=wc3TTpU2X32GYb2zm1AeBSGY9YjusqGb51pxekW9EmBNzNR6VVWx0dOi+15asItREJ
         GaJulSYH9bvV2HHzHd0a8nBeBPfIU4Pz26wy1tOUIwm11NVa0KIfrPC24aeO4zEj0Ivt
         1Ongt6++wTnKx8LwPwmefbPfVR36bmF5tKGJ8JUboWu3YkQhramgJ0wPaaZ4g5feMorW
         ui4QvFo434jcvAMLv1i8cutKc1TVyDor02m0CMOmLFTWDph8eTDhZFWyPA8f7jK0gk/a
         2YMRT0/nUSkeBFrKmHE3r5NYXL21+8r5ztfLLBXEDgCCCFqTR9dwp4ysloW45S9IcSb3
         pfmg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/Li+50sy1StAZnCV3wHjfXwrd8WqnfWzW+RNLk7vONThvDYTaF9WOoiQO+KQ0u3jhFuh5qUjbpDIjTmN@vger.kernel.org
X-Gm-Message-State: AOJu0YwKD18+dhWrkbSlmwbL5JW0qayznRVybbQ65GM+jPt9VxcTMGiK
	EQYLJaOH+QWJCtyAP+efKnDhb/f9P1N1q2s1bL8CCRGJyYIv80FWs5AS
X-Gm-Gg: AY/fxX5iZ6GKC6VAkQBWdGu7MVZIlq0E0/ii1j9eTtRrf+/fAjXpeTs11K4hGim3KsS
	SosM3LkOSq7GB7DkigFjhtISlBsifbo9eX4PenMUggjwq0hadbYA0IeSkRH5yqD3xDRMhQgXaI4
	oBJMhRhGqDXfNppXMUVKG0jcB+ZHlXSiu/s6R3zRi5cVkm/P8jAPxj2S5LmO02f67yZMLyYvOgS
	wFJ3k8kbLRZZhuiN9+KsKMbSSMHKPrgZx3DsOSeJVSzYamzx1UnACadUil85E9u25xccbOK5rZ1
	oz4441xQ1W8qAxevRfPG2RwcXKEtym3OYGsdFMCNL2ppqBQWtUlaQQp/d096dZZ7QQLPHtup5jv
	NlQnotxr67UxzJpfJRQgpW7HHLPRyl7AJOMdxOunvohPrsmulXEKIj3DDpy2evV4SOFJ0m4Dol1
	fg6z3aw6KJ7nuZ2yx46Q==
X-Google-Smtp-Source: AGHT+IHPSAalZDhQ4W90Khd8oGoAiFaQ0V3Y94CkXQWH65kUCL7t9GyQ23cHStEcEkn+KhSMT+Nvqg==
X-Received: by 2002:a53:d14b:0:b0:63f:a488:ba46 with SMTP id 956f58d0204a3-645555eb6ccmr9904880d50.32.1765932731223;
        Tue, 16 Dec 2025 16:52:11 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:7f3c:658f:3c84:2aa3])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477d583e1sm8364623d50.7.2025.12.16.16.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 16:52:10 -0800 (PST)
Date: Tue, 16 Dec 2025 19:52:10 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aUH-ur4n291DBj4M@yury>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-5-yury.norov@gmail.com>
 <20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>

On Tue, Dec 16, 2025 at 04:13:16PM -0800, Andrew Morton wrote:
> On Fri,  5 Dec 2025 12:52:35 -0500 "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> 
> > Tracing is a half of the kernel.h in terms of LOCs, although it's
> > a self-consistent part. It is intended for quick debugging purposes
> > and isn't used by the normal tracing utilities.
> > 
> > Move it to a separate header. If someone needs to just throw a
> > trace_printk() in their driver, they will not have to pull all
> > the heavy tracing machinery.
> > 
> > This is a pure move, except for removing a few 'extern's.
> > 
> 
> This one blows up my x86_64 allmodconfig, gcc-15.2.0:

Thanks, Andrew. I'll take a look.

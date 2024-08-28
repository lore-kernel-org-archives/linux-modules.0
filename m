Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D1D1AD9F9
	for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724882204; cv=none; b=u4fuMeeUF+T8TMMAfYqRrb/BD5CwPvLOPIOhpmXrgmZbEndLH63rqcaWHdF+0XnYJSO6MJ1M5I9sVSQkdQMDj8lF9ddmx1yzemNaafWd9bS15OvOHdDPJ0VhDy8J5P+JwExEG59c6fyd+Mn2+VhotS0FxzzMxyDcIIwU3T0+1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724882204; c=relaxed/simple;
	bh=PID4ATgIcRdlwJUDpahwj8UfLb1Vr51kkg4K6Y9E+zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfSaVnZOicPGCY/TDCFLIXJn7wxXPG/Ffs6WcZ7/ggMITkUo6gExw1Kfq0R9ZMLohpTYaOXrj34nVO8P958IPRWmobIHYaPQuiXGBEGKw7xNtsl94Gtzhksg3V2Cdl1JSXwtpigp39+anmNOZNWpNid72fh7I73R2zhnVNl3lNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u430U86/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u430U86/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20353e5de9cso61905ad.0
        for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724882202; x=1725487002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMJtTqWHyENpXYFshc0NGQIcxCOjJlWKHxL6Pc51Vp8=;
        b=u430U86/w41hIGFRxUWn2jOegZ4k8oU+D01A/WfKA6xHYh9biKU3pjpECPVqChTXeT
         lh1cnSqRaX7byzuwdtxDxnKpWIFMUVmmbh5u9Yg526AnskSHunCa/RGuYq9iJWUz3pyt
         bIOeiHXLS8Rq0JbG6TGfrkGVAyzbdE6FrqNS4qWL48M0godsDp1BxyNi3MpIyLolXEl0
         u7d7wNZ6DfO5QMytEPTUFLEkpfzwtHrwO4+Z9a1+CyWpEhw55v+xc/8v3Zh7t8SbEaKF
         T7+QXDzVJG+xqTsoqnKdHmizcldii+sbnNFkCqNHUr2aG5F3WVawzyR60yEF4xgyfGE3
         jQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724882202; x=1725487002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMJtTqWHyENpXYFshc0NGQIcxCOjJlWKHxL6Pc51Vp8=;
        b=I7y4IprZzMFTzT6dkhzG7xCMWvfsv0REVOhlUdhc3Y4q9fQTrQTTDQ8Rhi9wSlZxzm
         vodjYWNu87PUSu3B/rRzOH16fNuOHDNaaAnp/bWG6JVGM36vZSRetX/3p7MX+Eob4+K7
         WsqLPxTzIA8SJaMgUQfG1p8AtL2Ggzp//StPouxCYBeQoW5f5Vwvqaa9LM0ZudUS6a3M
         nj7aBelh1c1t5mJf/FQAA+rm09VM4GRCsoyhj3oFG+yBET7M3DkkWHTSUwXmR8qc3jYJ
         +ng2czArHybY9Gc70YJy9XXY3XKXucpCTD7qDWJpoEa0zV6676sCTSbQOKt/AoljvVZ2
         HVaw==
X-Forwarded-Encrypted: i=1; AJvYcCXr81UPYSSF3vu5o+COUHdxSoJGYRDscu/qz184rh8YS2G9jDXNsihVMi1YIRp4JsQRGtvrXbkYDTGu97P9@vger.kernel.org
X-Gm-Message-State: AOJu0YxltLBbMAx8rQtEAI0C77rdLyTmHzZVgEQg1t5GuTc/FVjIgwBt
	/tc5cDCh5PsKqWUEQxJXpkbZ8Wqc6aA+va/RLPzp20hw6KUV6XXngMczc7UxvA==
X-Google-Smtp-Source: AGHT+IFWsFfpSmAomvEtt5G6mILaLDEaIo62yZwexT1w7z/fqh1GYiNgxkqAWApkzmvRxk0nVu7qtg==
X-Received: by 2002:a17:903:187:b0:1f7:1c96:d2e8 with SMTP id d9443c01a7336-2050d1999a0mr965815ad.10.1724882201781;
        Wed, 28 Aug 2024 14:56:41 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445f9602sm2484968a91.14.2024.08.28.14.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:56:40 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:56:37 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 03/19] gendwarfksyms: Add address matching
Message-ID: <20240828215637.GD2130480@google.com>
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-24-samitolvanen@google.com>
 <CAK7LNASAzsgmkWGOU7WWuBMmzG4vPRDQLjyW4sW+q46QZT=vnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASAzsgmkWGOU7WWuBMmzG4vPRDQLjyW4sW+q46QZT=vnQ@mail.gmail.com>

On Thu, Aug 29, 2024 at 03:22:25AM +0900, Masahiro Yamada wrote:
> On Fri, Aug 16, 2024 at 2:39 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >  int symbol_read_exports(FILE *file)
> > @@ -57,13 +93,14 @@ int symbol_read_exports(FILE *file)
> >                 if (is_exported(name))
> >                         continue; /* Ignore duplicates */
> >
> > -               sym = malloc(sizeof(struct symbol));
> > +               sym = calloc(1, sizeof(struct symbol));
> 
> 
> 
> I am tired of noise changes when reviewing this patch set.
> 
> 
> 2/19 added malloc(), which is immediately replaced with calloc() by 3/19.

This was changed to calloc because the structure now has a new field
that should be zero-initialized, but I do agree, this could have
just been a calloc from the beginning. I'll change this in the next
version.

I did try to make sure there wouldn't be too much churn in the series,
but clearly I've missed a few places. Hopefully there's nothing
equally egregious in the later patches!

Sami

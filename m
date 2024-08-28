Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389661AC438
	for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881848; cv=none; b=sdl/t47OZt8OZ0Ux6TarUcaVepOjCuRGLOtk5pd5fdEJWMiRHSSsxjCBL1sb0njyVxtnT6a0L9nz6/CHQPKen9NaN5dKkiBt1oJryzAtpgJ/0FeZKiriWFxokoh3uHb7ERPj+XOB11mfQNsYZx7M6BwCXWdKuzTWCXfCc7+OtKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881848; c=relaxed/simple;
	bh=GkRq0ivoQpAiOEzaTGohkuRwvXQipTcElCzKrbs2YGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/Yl7L5lJmx8M09yfiJV9RRNQBidhb6F7SECHEZvQ+nBZ8EEkYPery+usAjuKf0kqb2hL9ihmrcCsivwtWBofx5Uldmjn0+dFsguwBlWZrU9d17kn2HgPPSVnyyP1ufdbom4z8JHemevSpRiicp1CFeS/LESce0CmRnKidklL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FenEweSg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FenEweSg"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-202018541afso26455ad.1
        for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724881845; x=1725486645; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kOlS11zZF40IO+TxYPwBjtED80hWVLwZdESib8W/thQ=;
        b=FenEweSgrJUH336ILbzBFrhicAIypPvYSt6nhniWn3aGXPE6hXzXxLnkGPn//2jsOl
         qjP2IeleGamF3+VqN+JHicphP1a+AreKsgI2W6DSlKWqh2OeOqEwLCdHYZitZMqkmJiQ
         3k0PjzE8LHj41EjTPG8eHCEHfKy1OtH2ZweseeN7K3oVGXXHkNCr10+m6VhD+DIT4aDw
         Mn1x0Q0H6KfhKpBxTzX6nAdofO6sAbcnDMCnSvZR6QGTFPvFCcuYRTE8thHI0sj4XMpE
         62AX/nAUpBbKfGODgcTcglYbiyxERiPexO4qJ2+Fe//G/FU3IhtSJLTL9GkvKvSJaNrm
         oc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724881845; x=1725486645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOlS11zZF40IO+TxYPwBjtED80hWVLwZdESib8W/thQ=;
        b=OKecHqkgqa+xDQSaM5wfoGy6z8rAYfhcrp2fBXyCHDioIW6Q9E6Pe3yresVInnbd03
         XcZJY5VAgdv4V7m/QG1+O+aCdA0JtWJEPkolXDDaI2+q7tpuphqEfnRoqZutIqdJ7J9Z
         l5Vsj/ApJRsKxdMVbXD526AkGAtkdejdJvObsYDERrKWvVqAfCLqqN+HO0TA3A46yUk7
         98QN+wYhi8TpHTjSiNCFifLDtBne+zYCftKqHyljEzVJ+7rpS6Im63ax9clnb619UEwe
         fspnXsrUP07iklThEIv6gGScBsXXNeuEDAT0bKcbmw3+ZxsmcCWcO+YFW/xSYLEUQfcj
         1r0A==
X-Forwarded-Encrypted: i=1; AJvYcCVnDPwxBUcGLB4Y8TMrw4akOQPFkg+ycMBN3NE8e+NDRTxMlF1s1AIIP3rKwtlf1q/RMzCE/IT642pOvIPo@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVpGn3mRo0lFTZAn3J/ypKu3jf5wx7Sr+m8BPCtS3Np0RmMWy
	esT6ohGLofFYaSBZyipPJ281R32WwLEIpWn4tYLI2sAhPuiOdJBUoEjnNEZCAA==
X-Google-Smtp-Source: AGHT+IH/W+fSipeqZ/wEzg8zzpJwjeYTFTuLFrl+gU3PBb15jaA3+7EFtkDmAEa/AEzYRe+ZhMBTqQ==
X-Received: by 2002:a17:903:1d0:b0:201:dc7b:a882 with SMTP id d9443c01a7336-2050d23634emr950865ad.26.1724881845281;
        Wed, 28 Aug 2024 14:50:45 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d844602748sm2481590a91.16.2024.08.28.14.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:50:44 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:50:40 +0000
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
Subject: Re: [PATCH v2 02/19] gendwarfksyms: Add symbol list handling
Message-ID: <20240828215040.GC2130480@google.com>
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-23-samitolvanen@google.com>
 <CAK7LNAS=8uU-FUpVqh-z-=7LOfXxYcDQExKLvB+6qe8Fdq_51Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAS=8uU-FUpVqh-z-=7LOfXxYcDQExKLvB+6qe8Fdq_51Q@mail.gmail.com>

On Thu, Aug 29, 2024 at 03:16:21AM +0900, Masahiro Yamada wrote:
> On Fri, Aug 16, 2024 at 2:39 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > @@ -105,6 +105,8 @@ int main(int argc, const char **argv)
> >         if (parse_options(argc, argv) < 0)
> >                 return usage();
> >
> > +       check(symbol_read_exports(stdin));
> 
> 
> 
> symbol_read_exports() is only called from main().
> 
> Do you need to make symbol_read_exports() return
> the error code all the way back to the main()
> function?
> 
> Personally, I'd like to make the program bail out as early as
> possible if there is no point in continuing running.

That's a valid point. The current error handling prints out a short
trace of exactly where something failed as the error propagates
through the call stack, but bailing out after printing the first
error is probably informative enough. I'll look into cleaning this
up.

> See also this patchset.
> 
> https://lore.kernel.org/linux-kbuild/20240812124858.2107328-1-masahiroy@kernel.org/T/#m5c0f795b57588a2c313cd2cc6e24ac95169fd225

Thanks for the link. In general I prefer to print out an error to
indicate what went wrong, but I suppose memory allocation errors
should be rare enough that it's not necessary. I'll switch to these
in the next version.

> > +int symbol_read_exports(FILE *file)
> > +{
> > +       struct symbol *sym;
> > +       char *line = NULL;
> > +       char *name = NULL;
> > +       size_t size = 0;
> > +       int nsym = 0;
> > +
> > +       while (getline(&line, &size, file) > 0) {
> > +               if (sscanf(line, "%ms\n", &name) != 1) {
> > +                       error("malformed input line: %s", line);
> > +                       return -1;
> > +               }
> > +
> > +               free(line);
> > +               line = NULL;
> > +
> > +               if (is_exported(name))
> > +                       continue; /* Ignore duplicates */
> > +
> > +               sym = malloc(sizeof(struct symbol));
> > +               if (!sym) {
> > +                       error("malloc failed");
> > +                       return -1;
> > +               }
> > +
> > +               sym->name = name;
> > +               name = NULL;
> 
> Is this necessary?

Here, no, but in Petr's cleaned up version it is again necessary, so
you'll see this in v3 still.

Sami

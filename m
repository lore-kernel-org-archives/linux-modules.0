Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3FF1AC8B5
	for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880537; cv=none; b=LqEc186ajkeZ1xrycE0naZmCAfPd6yw/F67GFJNm4PoRXiJ+gA8ErWS90LHXS9SYZKkBSEFKldXu288T8peE5VoUg90L1OdD1zVENRGDsvtnX9Cj2HvYMzSQyPOPx9+WMHp3MoRGEnJVyNxxb6Ea7iSLKyOD6dInOhLqyurTZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880537; c=relaxed/simple;
	bh=Z0RTE2liLWBqiPCB9noGezQt18J5+g8y4LpW/JuykkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmmg8udIUiJsMI8zwDrRtJ113FqqmdEnqpOyG5uWWpL3zPSRpdjw/ZmAj2O+Cq4gkGAY601k/D17lyNoNP2KZgsl5v5PxdRALZm0eC1iJzDe3dmXyxt2Aeu69XJaF+CZHImOM5/AfsAcAWowceDBk4tMnd12P31CitcKslQONi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQWWbr8C; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQWWbr8C"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201fed75b38so23955ad.1
        for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724880535; x=1725485335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvCelnyORp38Fj//fQhDAaDLLqzQaXh3WxOWjiSyKsE=;
        b=WQWWbr8CnOA+QSiiYyVX45MRQAajH6YZcgNknImYFBmnpImxvD8H8S6UvnCFDirYgn
         J/zvB2FCdsrf+hg+lj2bEgFcy9P2FtkJWGmlZ0gmh6jI9NRJ8Q7fUUzdLt/hWtBVf+iZ
         nBpD6JD6HzXRoZopPb65mDiJ/z/IxELsLcgQaQ35CmiK9fp78I508l5ZgG7281Y4NzL3
         i5z0ZEX6mUE+0+QAAqKMgrZ3F4JXV7BBnA/O1othgxRHiOgTyQvMnJx+0xpBMuPiNMHN
         uKib7AVj8GyMABYJuBqlrhanFO2muSmXFNEyTGS1/O1fRGEWo6/DRdZqQWS3KeUehl05
         QyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880535; x=1725485335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvCelnyORp38Fj//fQhDAaDLLqzQaXh3WxOWjiSyKsE=;
        b=LtNJYugo0o38hpCGS3cDkZ7YoJ7jOcvmXEs4zh5P82YOsoEDYZ8pIunU9FgI1tLjjP
         kKhaEaoMT1RETdPnSmkb2Ce3nPa7Gq8tUDL+k6TwVrXqlGvcrHBdbSrWgvNJbwEy1voG
         QjHtKwdIlpciCrZpUmVlAyWktFeMvDeFiWZ/RJahUFpT9Y+LwGtNgUibrb+tYyI+5rQr
         4DYVZUrDkWRCezPK5Ij2DtUlV1S+1ecIBzKQUiIKeX9lNoHXyB2ecKUoHGLJpKMMJ3pS
         Oce/qJFXee/q8IksQF8L0Qnb7RdtuBv5k/O7xtdRIOD0hFuv4Nl7Xu30BCiDpn38kHbi
         zxPA==
X-Forwarded-Encrypted: i=1; AJvYcCUGMwjB1EdZWBPINy+JJ3PTxbfQ9db2LQYTr1krNetEqTCNPzOswy9+PzgwH7GE+Xdl/TD5Wkjs3F6V3uGb@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYwhKk9hppXBDUb3QEZpzRivdEOoYprADlYDTl72LY/buTa7m
	6xzk2T69IdpOGb8C9/Gg2YZgqvGgHhmMYlR0NxYkrZeJ9I2YMiOTs/7WwTs/MA==
X-Google-Smtp-Source: AGHT+IGjAs0BZE3JhQUS2OaJDCYVlg0EV/R1OKIfMRFLb6EzIbnQK3Px/0wJ3JAypIISh5NpUzlhfQ==
X-Received: by 2002:a17:902:cec7:b0:1fa:191c:fe4e with SMTP id d9443c01a7336-20510b518admr220295ad.21.1724880534966;
        Wed, 28 Aug 2024 14:28:54 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560a301sm102665825ad.217.2024.08.28.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:28:54 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:28:49 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 01/19] tools: Add gendwarfksyms
Message-ID: <20240828212849.GA2130480@google.com>
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-22-samitolvanen@google.com>
 <71505c05-b651-4740-b14a-a53084a16a61@suse.com>
 <CABCJKufveknkc_ribOBamC_MXRGounFkYBeRkKhppPSHijxtZg@mail.gmail.com>
 <80e7994d-f82e-4f2a-b233-d4f9d6900698@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80e7994d-f82e-4f2a-b233-d4f9d6900698@suse.com>

On Wed, Aug 28, 2024 at 02:31:05PM +0200, Petr Pavlu wrote:
> On 8/26/24 20:47, Sami Tolvanen wrote:
> > How do you propose using the function? This loop goes through multiple
> > input files, should we need them, and we iterate through all the CUs
> > in process_modules.
> 
> I was thinking it could be possible to replace the code to traverse
> modules and their their CUs, that is functions process_modules() and
> process_module(), with dwfl_nextcu(). However, I now notice that more
> work is added in subsequent patches to process_modules() so this
> wouldn't quite work.
> 
> I would then only suggest to change some function names in the current
> code. Function process_modules() is a callback to process a single
> module and so it would be better to name it process_module(). The
> present function process_module() actually processes a compilation unit
> DIE so I would rename it to something like process_cu().

Sure, sounds reasonable. I'll rename these.

> On 8/15/24 19:39, Sami Tolvanen wrote:
> > +int process_module(Dwfl_Module *mod, Dwarf *dbg, Dwarf_Die *cudie)
> > +{
> > +	struct state state = { .mod = mod, .dbg = dbg };
> > +
> > +	return check(process_die_container(
> > +		&state, cudie, process_exported_symbols, match_all));
> > +}
> 
> Mostly a minor suggestion too.. Looking at the entire series, state.mod
> ends up unused and state.dbg is only used in process_cached() where it
> could be possibly replaced by doing dwarf_cu_getdwarf(die->cu)?

Ah yes, mod was was leftover from previous refactoring. I'll clean this
up.

> Removing these two members from the state struct would then allow to
> instantiate a new state in process_exported_symbols() for each processed
> symbol. That looks cleaner than changing state.sym and resetting some
> parts of the state as the function walks over the exported symbols.

Agreed, that makes sense.

Sami

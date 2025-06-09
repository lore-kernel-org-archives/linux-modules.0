Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA92940D
	for <linux-modules@vger.kernel.org>; Mon,  9 Jun 2025 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749507132; cv=none; b=m3ltC0BzvsQMhOoc8VNRomamixtOvczt4pTTrMIG+S6RSyGFz/zcI/A4Xu4+m/RJyf+nMaLi1drKaAia5qGWO3Ahw7hJ5XN3wPIkugyf+xePzVS6A8tfZ0eRGy3ewd2udbHwUO4stAuDeLOUfz9qkKq+sjbHs0QihrMv5/cRvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749507132; c=relaxed/simple;
	bh=Q096VwiTTUVf+mPt3DUqJJru+Vb3D0DDUtk3t41e+mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiTzyvB3uK1kpwf3eo0dSTAUYTNtawcmD9B0D1MSa2fa3LbJEMvMb/8wxAKXIKbaYOSYEfVL2dE/1GMWLroQmXNwfN6rkSUD0DY+/sBrdrbcVpixXC7EtDvYCICcJRs+o4xyQ9rjanNVNASrD9tmWP4KDLgUDOSH3cmrhTl0xnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/bxh2O+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/bxh2O+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2348ac8e0b4so18435ad.1
        for <linux-modules@vger.kernel.org>; Mon, 09 Jun 2025 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749507130; x=1750111930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOEpQR48459oRBgMpH+r3088NqHoqtjm5LRzsigSh8M=;
        b=T/bxh2O+Gbr5dVl97lML/A6ZxR+uehVTdoljFXZkysaypggDFM5ejiXqrHpcNcP3TB
         BErk8t6V9h6+ZcD8toi6oKiWNsuf37WhqmFPRbrkqgDW1NP9I/R7NHOk8fZezv82jHh+
         BjymawOPmBNELarNMPirCcRJji5RPy/IAxP3SReT20UVetTGEm+LaEgKhhKDS5kD5UMJ
         /pCTp5w58REiJvgiJsj/StWLI+jgbXjbNRBtsRHiQhcU8fBfnKgk4NFP0i7sI9GPoFhO
         VQiNbIxa5TxH7qziWd8lKz8CbSCMcYn/CKoTnaKMM7SiwTUk39nIekSw85Rgwz1lhgXk
         ViUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749507130; x=1750111930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOEpQR48459oRBgMpH+r3088NqHoqtjm5LRzsigSh8M=;
        b=mn4xoJQ9rpN2vmZmbt/OSzvLIt3FlOqWdTyNWh2+S7+HjSXkZJRUQKidfDp1Vh56/F
         Dtlqr3kSyzq018pWSQfhLnsfA6PYGQwTUi+D3kTzSugjG2YgiMEETm3z+7NjQoPTp7xl
         3xTJWW+toqbUbCfPN8k3OheHGOCLGSv+r/GBjj9sQO8p8xsgV7mGGqiFiaKGbvRMEZOQ
         1CCODFuzMj1tEWB1NfsPnfNNU5+gP2/ld1Xl20R0wK4nZPXACYFabQaw2LpAE1rLcZsN
         yJdmZ8XvpkIfIRzFCHipCRdoQ+WCi1RBZxXeRoKqOEZpDSX9vWHSWnVD0KiQi9zjYDz+
         jA8A==
X-Forwarded-Encrypted: i=1; AJvYcCUmdjOL2i2rX/n2gmAfPAadsbyut+ftUviW6QGmwhqlNGrfkYEyJMdeV/kNz6COi9nBZMHs/WJM2CKmJ9X5@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPU2C9v3n0VwPoFYXXq8N/W2HXJ0kb4Zm0gu1s/tYkpZ0B1AK
	/lJBYgTeNvPCjGCl3aGC6VQAZGZ+mAS1EiTfsFIUOpvxzjdvXzxy7MmaZHIUR0jgzQ==
X-Gm-Gg: ASbGncvd5+IcQRJkNT+xJWG6uazJJQ6f2q5Rv3ei9YhdS9iPxacQrufQdL+yfq6LEIJ
	FJprgopcvNQos9GxSRc8W4TABLkLVDYrJJ1t4ZDzmDKWSOMVRgvZiJvsOufERXfapWs/Iy5Ejkn
	MmTBrRsRx4LyDFBb7BZ6M4NDV8qq/uLwY7YIRmg3N7TPd3F1Mc7+FSGIQNZAFRmg9O2R27sWPNT
	xpnlFepfZSRy/CbXBPaUlrx15+NLkWVPgKTH/tzhM4kLKnLNlYqHwB0ifS3PypN4R7f/x/ZDhcO
	ZybaBFeP9rZtk53CuRCa2XDlx9OGDqPBvNtgEag7krnxHPPaEVOOUDL1RQXzZnh/H+pMqcRS+rp
	4Pkc5BUrs9xwsUpzVqoetoegza06HkDoU
X-Google-Smtp-Source: AGHT+IF2AY3T20FOy8DmpoVu7vdEGvItzPx4tSajszVB/X4+P5zS/jWc325IG5gFLeSy31rddi6wAg==
X-Received: by 2002:a17:903:1b4f:b0:215:f0c6:4dbf with SMTP id d9443c01a7336-23611fd8362mr6331895ad.14.1749507130159;
        Mon, 09 Jun 2025 15:12:10 -0700 (PDT)
Received: from google.com (164.135.233.35.bc.googleusercontent.com. [35.233.135.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313286f38c4sm6694653a91.0.2025.06.09.15.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:12:09 -0700 (PDT)
Date: Mon, 9 Jun 2025 22:12:05 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: Fix memory deallocation on error path in
 move_module()
Message-ID: <20250609221205.GA1439779@google.com>
References: <20250607161823.409691-1-petr.pavlu@suse.com>
 <20250607161823.409691-2-petr.pavlu@suse.com>
 <f6fa3df3-38d5-4191-96d1-9a8a2152cedf@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fa3df3-38d5-4191-96d1-9a8a2152cedf@suse.com>

On Sun, Jun 08, 2025 at 09:25:34AM +0200, Petr Pavlu wrote:
> On 6/7/25 6:16 PM, Petr Pavlu wrote:
> > The function move_module() uses the variable t to track how many memory
> > types it has allocated and consequently how many should be freed if an
> > error occurs.
> > 
> > The variable is initially set to 0 and is updated when a call to
> > module_memory_alloc() fails. However, move_module() can fail for other
> > reasons as well, in which case t remains set to 0 and no memory is freed.
> > 
> > Fix the problem by setting t to MOD_MEM_NUM_TYPES after all memory types
> > have been allocated. Additionally, make the deallocation loop more robust
> > by not relying on the mod_mem_type_t enum having a signed integer as its
> > underlying type.
> > 
> > Fixes: c7ee8aebf6c0 ("module: add stop-grap sanity check on module memcpy()")
> > Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> > ---
> >  kernel/module/main.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 08b59c37735e..322b38c0a782 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > [...]
> >  	pr_debug("Final section addresses for %s:\n", mod->name);
> > @@ -2693,8 +2694,8 @@ static int move_module(struct module *mod, struct load_info *info)
> >  	return 0;
> >  out_err:
> >  	module_memory_restore_rox(mod);
> > -	for (t--; t >= 0; t--)
> > -		module_memory_free(mod, t);
> > +	for (; t > 0; t--)
> > +		module_memory_free(mod, t - 1);
> >  	if (codetag_section_found)
> >  		codetag_free_module_sections(mod);
> >  
> 
> This can actually be simply:
> 
> 	while (t--)
> 		module_memory_free(mod, t);

Looks correct to me either way.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

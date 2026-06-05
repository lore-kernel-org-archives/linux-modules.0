Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DC3542F6
	for <linux-modules@vger.kernel.org>; Fri,  5 Jun 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692742; cv=none; b=OhlVNlUWiuyCfGYLLMronKJvMtcit5d/fpxMr/iF/Ot7vKCcg8XY8u35yH3MLniJIdDs/sSj0Xh9wJcBaXtLKHAu/Vfv1tRwlsKvjZo+TuS6pZWlgmEHPQAOeNS2kfxcLMr5s69U69rbhSBMpxbb0bfL4nryQPaCGqG8PVi8pjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692742; c=relaxed/simple;
	bh=xGojLbLv4NQbqNDSq+z3GuSE7kuOp9PLy2sVJwoeaRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR2DNK6fXDW+zHz0W2RMuEt2D2fnlTq9G0Hrg0jmcr45F0s5v73e1oaNIjey40J4Hin7c5EIMmNkmzhBTNeXG7gE69d6DqCuic9N92Qi8yrfEq6+r1b51Bx26yQl0FWtd+mboiNzUHFYI8FFb5B+ZZcOOITnKl6FBh2e5jpHvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VIBVClby; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VIBVClby"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf22c18ad3so183425ad.0
        for <linux-modules@vger.kernel.org>; Fri, 05 Jun 2026 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780692741; x=1781297541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/aHCGrw+XIjtdqLkW4WanUic2GE7XJ8o4FzpEgOR7w=;
        b=VIBVClby+HSmsBRO2QbUBgCtMriMml89CTa9ChU07RJVxxe1OsWMyHU2xvWscOoqce
         sdBmCX2AQzE6t1uDmzhTWAZFgsIoTexNxkwx0UGmS4B+EJ0A94k6X8i33RwPD5d6FyU1
         azgQ9dQe+2K9k0p2IU/hd8EJwfR/aGzzvwVR5spldUq1tS2uFE3E7IspT1ADpbb1F+Bu
         qQLtxtGR8eVdgsdqjsKNhLcX/1NTnCp/uhgONl/hOA9OqItSFtOiFK+Lv8IWB2j/2toZ
         NNs1ouBOa5/Ejp0dXZexqDl1LYut0Dk0L3CrI+Ha0UEDeerrKXuG9IwttAUs443fOvcO
         1sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780692741; x=1781297541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/aHCGrw+XIjtdqLkW4WanUic2GE7XJ8o4FzpEgOR7w=;
        b=Ib7OB7eV1r+NRPK0mPi4HLVGkSe7M4v/M/tbp/Y7Am3tNrM/7ZEt/ufGnDJPGCZeEG
         41LWV71W1y9h5TiLAvSywN2r5/yoghERvblHa8JyMVqmOOLNtL8mdshwSMew61MoITIg
         MqoSMyxqD4lV5z7lpmZSbEvvubQE2vjSNMjc4FPl6ConvBqRPRcYM9gUC01i4wE4gUNg
         Z94g4eX9MZD/OLdcgT9/VykuxdsEGDX1kCrbPnVsMkhKoJ0SBWH6djMpHAjaf/7q9ND8
         CfZ+UqYHzmNQN1dNDhdudqt3ByaVrMvff7Gt8Djn0wXWClb7u/IUhYQkpuc8HbDJuu00
         5aAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VXxcz9HowTTqnZc3a1THRXli2d5BRtSW8I/zIhnJHkWPRQ6SxUR15Pbrkl6eNa5HIYayC0/Fl18VX+gbs@vger.kernel.org
X-Gm-Message-State: AOJu0YxONYJpDGDzrjnUvglVQuweRn3Kx7WDZNrjUfa20VXf0DWWSifi
	3dfSoyVnhTcCp4luCBVEU3KB4N3j76fR10jopywLOjzQmhcCesd3lcyN0jpjfDxJPg==
X-Gm-Gg: Acq92OGR/BqI5/1rbOytSo3A57U/pWvDujNb6OWSyOYwc3vLug/5l8+LokrnasvOySn
	7Y0zEG35TG2oQNzs6x6bflMq636G+1KVsz7lPHAHO0rMMoZO1+pErZB8auZE7JYIph9l655bUjQ
	pw5GR0v/wj7+CJSgBZVF0BVk2tABjLM0Bhce17l6BmGjvwLwp8EBFdAMMpYx9zAvZQLzoyX1OAf
	jp43IHHX9O98UTDNfq8tynfgIalw//BTdKAGaNqEfYxmzqfhND1LElQY0BSOOVMKG3oRuAauDXV
	4o/cHmi/2XyPPe+xPfaJ3t8huCDUDFeLJmEegOg8qJfEE28uIWImujeIc51VvQDBmtOjId0zqOn
	JDfjIXkVOKONddtvDAoApcr5mhbzdIi5fPkLLkvZAD+XgXv3KDW3IOuBK7+QTyawbUe4Vw9RAof
	f/q/b/U8AJETvCuIO4o58h4vuh3NuB07FTr5wOeXU+7K61SAIXu2PJXw3fqjULjFFIornhNuYYk
	ODD2ps=
X-Received: by 2002:a17:903:910:b0:2c1:4a67:5f31 with SMTP id d9443c01a7336-2c1eb0c6c40mr2000735ad.9.1780692740156;
        Fri, 05 Jun 2026 13:52:20 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa00b3sm96312575ad.32.2026.06.05.13.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:52:19 -0700 (PDT)
Date: Fri, 5 Jun 2026 20:52:15 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	atomlin@atomlin.com, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: procfs: fix signed integer overflow in
 module_total_size()
Message-ID: <20260605205215.GA3054112@google.com>
References: <2k7x7245kygzpa5wzssebsrt5ivpykvvoeiljb5at2yiwgp4fy@fqkcethe4hyx>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2k7x7245kygzpa5wzssebsrt5ivpykvvoeiljb5at2yiwgp4fy@fqkcethe4hyx>

On Wed, Jun 03, 2026 at 09:54:11PM +0530, Naveen Kumar Chaudhary wrote:
> module_total_size() accumulates unsigned section sizes into a signed int
> before returning as unsigned int. If the total exceeds INT_MAX, this is
> signed integer overflow.

This doesn't sound accurate to me. The compiler performs an implicit
type conversion, but there's no signed integer overflow:

https://godbolt.org/z/hzGrYMsPW

> Change the accumulator to unsigned int to match the return type.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> ---
>  kernel/module/procfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
> index 0a4841e88adb..90712aa9dd13 100644
> --- a/kernel/module/procfs.c
> +++ b/kernel/module/procfs.c
> @@ -64,7 +64,7 @@ static void m_stop(struct seq_file *m, void *p)
>  
>  static unsigned int module_total_size(struct module *mod)
>  {
> -	int size = 0;
> +	unsigned int size = 0;

While there's no behavioral difference, using unsigned int seems like
good hygiene. With the commit message corrected:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

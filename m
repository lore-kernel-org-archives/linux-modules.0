Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620B2BDC2C
	for <linux-modules@vger.kernel.org>; Thu, 18 Dec 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766101074; cv=none; b=m4F5N/gqx2VWxFF58OGBH+C9DWfzemEw+XruZsGk6lHw7P6lcR2Vzn4vEyZyHOa5NLOcXkBDMexGcIN5zUkuocJ6pov0Du0amVR55Ki1YdfxxtJZdqlmAfl50BEumjUuGf8OnMU2ax3+zdVGFraidLU92Tg6j1hYBLvGYubOWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766101074; c=relaxed/simple;
	bh=3xlG6FYPR48UFVUeYAAdpz6olWhBuChTlR4EX2RSTmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzwVdYyRLcRRceRGHxwmtQrHRqD9G9qCGBVUgjKNjRmgG0/nfcwrq+PCk8BwWRY46k68AwJVtjuet+6vpOHv8UMUMaJjMafiqYn+nSHPfPtf86YZxu5Wvc3o9YxbwKYyTL8XoJ0HGCoIHC44byejy/ysHC37oPK5D38niTn+iCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B56SoBTW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B56SoBTW"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso1743566b3a.1
        for <linux-modules@vger.kernel.org>; Thu, 18 Dec 2025 15:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766101072; x=1766705872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZalkBGMZvwmDVV1ya5Lu+/scueeEmPRx1djh9JCuvk=;
        b=B56SoBTWisVDDnhjDS2Wz9+kAkmZvXVLELbFwjKLqDFwtJlrNtTfFHXXXpLY5yexC/
         WTajhNjaR3kIex1591/sOjRAGAktKrOtb13WUhREB+9NbHkO1Mkc35ogQzabegDgMfcG
         lSmLqMV3yoPksXpdF+cbFY+phVZX8UU3EqZCStZZbMUcFE+I6z2NPzQBasHerucAF6Gp
         7hC8vLh0QIGZohXnJd93bbmM/Cp0Wm+nGrJFNol3BmJjsMLNxK9Pnj0KaRtMmnBMasKz
         Sntin7+Qv5UItxvlv1vOr/A+6KFcEoIYYvveY6GonnKFjL2TuA+mcPpMFiagavnrssgQ
         ecaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766101072; x=1766705872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZalkBGMZvwmDVV1ya5Lu+/scueeEmPRx1djh9JCuvk=;
        b=hBWc26HFkIjglrOJkn+gIEifSE1dra0i22L4y3zvKFiM9iXhiOPTlZyMuH6BF60PFS
         ioJLYCe2eTTN8YGmFIB8U2uPsOy5zG5G3LLAAGc21RuGX1PEp2++L1Y76RxCKEyeSpw+
         vGEsyi4gySfqP4qVltabkyn6hmoA6t6vQ5AXxgXmhF9PdMKH8dvwNQcMBhEAwQ16NKpu
         wSd+E5HYwD3NqxsMT+0/aKSxAboeH+zSETg2dazOBr4eiS6Xkn4T3lGsmdGBTbNbWMlA
         bzPyBqxBZN4lSatzsyH3eFUKOpPi8r/OsJ6jTiuwXc1YFA52frSe+M6GCT3SDNnVBqoR
         fZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpdrJ1Yy5JJBxrV0weUgCtt3udzR/es1q9GYnmoBGRmLW3126WlYeyN94kG6yakom3/9JF2FAc3qTGzAZ0@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGa4G/LwC5+a9fpmi8W9ecnIk0vd5EqpdvMaxm1oBYdL5ymc6
	sUSUQHRITq4E6Fdei+c1Fv1fwD7UhUgSv8l0T1kls1Rgho6Skp97+uVHKsmFjA==
X-Gm-Gg: AY/fxX67VMTUPT0Ewd98TaHjVoaAwGaqaqPr8ICxWeM8nR/u41T+FEN+ywv3JHDJq6K
	wFrcoHBSWKckplUozcMJY1BWl+k285/RW0VnV4ndmrfmNET05qvnRzr9S/uBX9VCwJEaItkqT/u
	e0xk5Fnpalu56Fgg8UeBv3J1NV20kThWGrGJOwYvYdQemIHPaNM7oNy4gcYqMaF2AVoDrCBFHYZ
	hhVlMUpW1JU+lkElqjh42vRCYpePDuSs+uqEAT+2Sik6bg3SvTfcVIt7WzKnpQlvoT3OR93pC+4
	/bH2ErpCqPfRfi7bQ++CoctqoLpgwOV65PUG+VRlHDjkVHnBfVzevhliAenN36rG8VRmXf75mcw
	O/hNGUvqukBF+ntFgZ3rOw7tXe7WuWxOpVGXmdKf95L6osEQhyjiTKYzXsolu5YBmVCL4N2kPfF
	UCHSNK3Q==
X-Google-Smtp-Source: AGHT+IF21Ecc6Jc0533/8GWL1yiDmEnXNfeJkD3kNuw+xcQOMYUm7A56eghLjVuqVAs0d9Em+kHEaQ==
X-Received: by 2002:a05:690c:7012:b0:78d:6d62:f93f with SMTP id 00721157ae682-78fb3ed3062mr7661257b3.8.1766094799618;
        Thu, 18 Dec 2025 13:53:19 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:c44b:debe:992d:e6a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f01e5sm2294447b3.35.2025.12.18.13.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 13:53:19 -0800 (PST)
Date: Thu, 18 Dec 2025 16:53:18 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
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
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aUR3zqq4-qMV_bFh@yury>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-5-yury.norov@gmail.com>
 <20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
 <55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>
 <aUN8Hm377C5A0ILX@yury>
 <20251218123349.35339242@gandalf.local.home>
 <20251218124326.22334325@gandalf.local.home>
 <aURlK1gpCrfLEKN9@yury>
 <20251218162542.476009db@gandalf.local.home>
 <20251218164103.3c535de3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218164103.3c535de3@gandalf.local.home>

On Thu, Dec 18, 2025 at 04:41:03PM -0500, Steven Rostedt wrote:
> On Thu, 18 Dec 2025 16:25:42 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 18 Dec 2025 15:33:47 -0500
> > Yury Norov <yury.norov@gmail.com> wrote:
> > 
> > > > I don't actually remember why I had __trace_puts() pass in the size. I
> > > > could change it to:    
> > > 
> > > This is the best approach. I'll schedule it for v4. Would you like me to
> > > take it as-is, or you'd send a patch?
> > >    
> > 
> > Let me send an official patch.
> > 
> 
> You can find it here (I Cc'd you too). Feel free to add it to your patch set.
> 
>   https://lore.kernel.org/all/20251218163739.5605f9ea@gandalf.local.home/

Thanks, will do.

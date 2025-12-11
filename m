Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58AB26CE2D
	for <linux-modules@vger.kernel.org>; Thu, 11 Dec 2025 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765441740; cv=none; b=BMXXs0jdU8aepmKhU9SdayTs5bYfAzwcnyuakT+rkRaFG2ddRNftVLNsrBAzfd27lAVRhgdLrpUKGyV7O8m2LqZZOV1+Xzb72Frb7Wu12o0lwxQcMh6RkNGR5bi7ogxknZb1byRJBBZ3wsPDbXugmGm8HMkWiVqwBUmiq+G9V2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765441740; c=relaxed/simple;
	bh=djjr9+IAia3N6sWGx6zJjpQoQTmY5N42PCLnoR0yZyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc9Xr/lhnAP0O8XX1yoQgaHzR5G61Z7P5pJcUfu83Z/T8RUk5KNEu4wLWAdjrEFGoowVPjQsVGAUELyWFZbhCyXVhxUEwqrCfBfefLqawzkhnQ9qZA19HRHCUcWsakg4/tgfWvcqzNk5vCcjVs+Fhm/36mmimktBOWQ8Jt88DQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eAt4k5n+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAt4k5n+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47796a837c7so4950525e9.0
        for <linux-modules@vger.kernel.org>; Thu, 11 Dec 2025 00:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765441737; x=1766046537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhOVP0Qk4QJBwZMBL87OrBgZcGud1+QQm5cvOUQeo/M=;
        b=eAt4k5n+JRFJwicM+0Uo0KHutKyRY0bQJjO05nR/ESPLuWWFqbkc0hUWLV3zQ+5qAr
         2TFUzA6fVtW9aI95GWe3BtMRSZRgNBYSujxuoy7B8C3+sSzS8ztL0DoM9kFyo0PAr5R/
         88ex/FKdoaAr/cSz0dyPBE9g27mKszTX15Xdl9pQKWA8Mg4Sn9GwWR/WS9MLFfzpSYi2
         hC4vC7iY8gxQhPmUuomMTbMPv/naRJKbelNVtVf1ymvKTAt9I3doic4yihYRmJe8BSKa
         PKccPg3o/5rhA8zmzLwZnmcWANb38sesxBaJkBN+XLK1h34HjOtlMFVkcJT4AU/2j0oF
         fSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765441737; x=1766046537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhOVP0Qk4QJBwZMBL87OrBgZcGud1+QQm5cvOUQeo/M=;
        b=nxTTCOe2UdS9SLzu4V0tz3bvuJfPAEzCv8u0Tcg+OhJL++tmj0iJiYFLvWqSShFi8K
         9vF8RKI4KtXi37GP3HM7rLxuURZ6YDFfOJqw9mrIuTTGFFJ/FuZqL+5i0AbdAg1MLV4H
         V4v95mtrvvz4A6wwm8QEaJvjN3tgTbo4GSLX8SQuvwvmmIzP+GkyGcC+MuQPICt1R2zW
         eynfiJUW9nZZYR2VpnroInn+yqjpUP1b75CjBtYrE6yjVrHLOBsmuQGMwKJeQpONxjVY
         vhC6K8WESPgBOXHAGQiAMtRhlrdLpWU7Zw5rV/q9H2X/DlJi32TShvs5mZFTPFRL/aAi
         qGcA==
X-Forwarded-Encrypted: i=1; AJvYcCWBK8lUBRLdbF8qNuV8BAGCn6JHubIpjkhDuQiBs4HKDsNPhw1Yl7rorVrqIm369JOHsiHCXacKTHjRHSyK@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfFwOhIQQuuWevgd8eL9X4/PTVwhxOFogJ0OYiaF31hhnB3en
	7u5hAd4ztjblGSyiUFAfYZA5shs+m2Y+aMxgvcIWsSMmpmdZ+C5h72mpffk49FgILHc=
X-Gm-Gg: AY/fxX6OdilyaMUEeyqrthiZptuzXRkMROYeo0SLrShMk9OYZi93x1tE/uECpAl6A/G
	gpGRnRh/E7TTt8FzYBmI4K3BfbGkZ56Q5OOBY1/sm42gy9ce2nrxIu/nXNuxAF4wzloET28JLnI
	/CbiM3+g4loDvogA3bkEqZ5dqz6zIOejxJhkyMnefaowFR72Bbg+CtfAINvP4T2hL8YUNqr81qs
	AP0mOg9KXORAJYt4kfa/ZhmzHHELHN0QcJFua6sl71ALmzrBQlRpDRojY5FzmN6YEfQA2OK0+DD
	sNL3VP2AKwnBIeeSAJTXBtS7tnAZu1mVmlRLd18bVXrerEI28ZDlS3+f2W+FA9Fo13nAEulM6I5
	5Aa88PWKpeY9/WPN4Gq0XQoGyf8S3npCTNUaD40LEDC/H66e0R53+xpNmTgPRqJM/3ru4dn/+Ti
	btJHHaIlUfYIMf1kts
X-Google-Smtp-Source: AGHT+IFgxdBy65p84fy65/fyiYE3miPmWBnt1+Te9NK6eCwaQurMoPZNR3/Cq1AwdP418CtOTItATQ==
X-Received: by 2002:a05:6000:2309:b0:429:c711:22d8 with SMTP id ffacd0b85a97d-42fa39d2ef1mr5723924f8f.15.1765441737154;
        Thu, 11 Dec 2025 00:28:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b1f1sm4079889f8f.39.2025.12.11.00.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 00:28:56 -0800 (PST)
Date: Thu, 11 Dec 2025 11:28:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Chris Li <sparse@chrisli.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 3/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <aTqAxfiVCR2ch4I5@stanley.mountain>
References: <20251008033844.work.801-kees@kernel.org>
 <20251008035938.838263-3-kees@kernel.org>
 <aTc9s210am0YqMV4@agluck-desk3>
 <20251209001139.GA7982@quark>
 <d3dd8fc8-ab46-4cf1-87a9-0324685ba2e0@kernel.org>
 <SJ1PR11MB6083C6D97484ED4E4710268EFCA3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aThSGiKwJRYOB6kx@agluck-desk3>
 <aThqcq0iGge1pQCr@agluck-desk3>
 <20251210010020.GA2522829@google.com>
 <aTn0WdVv-S_EpQmS@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTn0WdVv-S_EpQmS@agluck-desk3>

On Wed, Dec 10, 2025 at 02:29:45PM -0800, Luck, Tony wrote:
> > diff --git a/expand.c b/expand.c
> > index f14e7181..71221d35 100644
> > --- a/expand.c
> > +++ b/expand.c
> > @@ -535,6 +535,8 @@ static int expand_compare(struct expression *expr)
> >  			expr->taint = 0;
> >  			return 0;
> >  		}
> > +		if (left->flags & CEF_ICE && right->flags & CEF_ICE)
> > +			expr->flags |= CEF_SET_ICE;
> >  		if (simplify_cmp_binop(expr, left->ctype))
> >  			return 0;
> >  		if (simplify_float_cmp(expr, left->ctype))

I'm not an expert in the C standard, but this feels correct to me.

regards,
dan carpenter

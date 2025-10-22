Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CA315777
	for <linux-modules@vger.kernel.org>; Wed, 22 Oct 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128384; cv=none; b=AIuMseb3vmAYyTnRXs9m2iwwBnUTgXSSBPLy9Q5oG/Cyxb9qCFtl6lnHcuZsUJqD7mkRWC3sRbo7i4xOQYZMfMmyjJXx0RLau1+u593ztwt5CxWALkJjpE+6UKzI+89AQA6aUj2914x+gWOnFmxR4zipFNqDjW7hAYIXI6SSbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128384; c=relaxed/simple;
	bh=joBEyn5l111nZ9jGESSCAOmkS1tgkzPeMQXORmoeZRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euj6TaK0wiIYsCBx0KzSHNqcM5gzNhX0MVlKu/+/D6oBwtPG7QYXqgyskC9KuBcvN+k5nbUXWFcha4vs4CDXSdrqXPpF800yaHBkJCwtPyAyp8VqOvDT1jk0P6fNGnCEO2zpNfNyfTjeFyGPY99ogxs2ElEyS6bFhZ6Iggw3Gaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DzCFpZJc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DzCFpZJc"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4712c6d9495so13371195e9.2
        for <linux-modules@vger.kernel.org>; Wed, 22 Oct 2025 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761128379; x=1761733179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXyDXixja6RmZT39Er05ZzpCC3vXUho6dl9B7iE9rfM=;
        b=DzCFpZJcaEvh+evRO3GsyZ9vyb4yBLLh3ggw32alsNuqluiISUpz3UoIumLk8EKYWB
         j1tKj9zYVv+b254EpxtPmDtClRMxMaStwRi2SJCwGwIgJRd7+ynAbhYuisRLRCkp6nHp
         1/3VJaWJApP740/PKVxjX/I80Kw657fBVlQNXlN3t2aWnqOQ0aN++5fHDgP1jt3yCcYA
         L1Jr4hLl6sqwLAArSavbfSTnWoxi/+pE+O1vouEu2PiOeCCbGRnXls7UNJ9CnttxvnnF
         07N5sztahQPybwTnLOY7zpSeXqIdeZBKIJ6ZhmcHsPaQ7slVUGiIuqvGO7ISAeDTkZCU
         lm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128379; x=1761733179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXyDXixja6RmZT39Er05ZzpCC3vXUho6dl9B7iE9rfM=;
        b=oNOvtzuDOrWg1glRGYnEXGLku7w3ToyNIo/XT+DDG9HEhjM0tjUcoJ25tBUFrdgAvb
         ZhipS8hkny5g6PYOZ+mJ1wHlanksEG7exFHwhtkk8+TvuruhQ+6ASMwfzeRKJ1hvg/ON
         WZg5wyb4pG4uph6k5RA+9WsuZR5O8Zb381K+DNzVe3E51gPk0xomYRC7O11BAiutzIQ9
         lShUKldMFi+2AMNBtrRi3nr+DO+8lGLEwRAgU5bToj8NKvNqxpD7NlbMrDde4GWHzBSZ
         PHUKM69fTAnplAheTXt9FIfW7uVOLc/wVXh14AdwQMY/G7Aoi2pk4isX3/6F63nEKLji
         M/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs8k9tgdvftAP67gI5JI0KzgKURDk/OAaNq0bcbLLea1bKMAG1ljTIHFHulXYiuh4PGq3CePGwTGZGROTV@vger.kernel.org
X-Gm-Message-State: AOJu0YzCsqwCmfe4KHMPIlaCRktVUQVFmwkN07h0dLjfWXR19Gmb3sme
	ddZCBhHDjLxvOSIY2DIE6OQXATRPghL5PprnnOdPmncJarPt0AylTnFY2ED63a0BO40=
X-Gm-Gg: ASbGnctXj5RzHIdADGhPXTnN5NvZUaTSUIhJuFN7UI0W2JHkoDO5afSy0/KgLsg4jTB
	+ic+izCfS5ShNS579UL5VA2UeMNVXFSs7eyWMbVABl1y3S1SIg1xvT9HkIGmpfGoRpEQMMHid+d
	RMt8zLXr5qBASpPwC1kR89uZwK+ZP3/prZ9PSSj4PbLOEwSspiLE0EEglXzuTVV0zYYDOwPIgLG
	rwJLTtu6mPC04kDosZGbrTanWz8z7mqSAPAwMkS8JtiXoNY1t4DsGoxwpmlbZ52wLw5qsJPWp5d
	j8Sz9rajD45+vN6yc5RIqNcSTOh9ywduzPWge7T20NiCZa25+yGvjgTJwOiYr/ZFKFSD0/u48Yk
	9E8e/gpcK6pZ2OEcLr34akrCFYBlHC7ycwhYqRlaf3vf0O6R7WBJL0NV4xWLIEqkJOviKyzkCNC
	nSY5nm9BDcmMJkWw==
X-Google-Smtp-Source: AGHT+IEbwRIxqwOcW6k8/RNZuYBz6gOsWXSzyHrVYvpQPGm+n70PNasZXailVMdY6Pt7W5w8c1E2Ig==
X-Received: by 2002:a05:600c:45ca:b0:46e:59dd:1b4d with SMTP id 5b1f17b1804b1-471178a4bb0mr148080655e9.16.1761128378963;
        Wed, 22 Oct 2025 03:19:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b3esm36179955e9.13.2025.10.22.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:19:38 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:19:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taint/module: Remove unnecessary taint_flag.module field
Message-ID: <aPivuD7CWwHBRcZI@pathway.suse.cz>
References: <20251022082938.26670-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022082938.26670-1-petr.pavlu@suse.com>

On Wed 2025-10-22 10:28:04, Petr Pavlu wrote:
> The TAINT_RANDSTRUCT and TAINT_FWCTL flags are mistakenly set in the
> taint_flags table as per-module flags. While this can be trivially
> corrected, the issue can be avoided altogether by removing the
> taint_flag.module field.
> 
> This is possible because, since commit 7fd8329ba502 ("taint/module: Clean
> up global and module taint flags handling") in 2016, the handling of module
> taint flags has been fully generic. Specifically, module_flags_taint() can
> print all flags, and the required output buffer size is properly defined in
> terms of TAINT_FLAGS_COUNT. The actual per-module flags are always those
> added to module.taints by calls to add_taint_module().
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Makes sense. Nice trick!

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

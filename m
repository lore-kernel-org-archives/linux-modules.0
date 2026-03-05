Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420511459FA
	for <linux-modules@vger.kernel.org>; Thu,  5 Mar 2026 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754232; cv=none; b=ltHohfEqjBl3X52y5ZNYQZbCCtEXfoJgmkSdn7ucAyJh+4QX9l9QyNBZlLg/CWIPcopH/e0yg8ibzSV5/0P2oG8rr90PQY4CSnbTskIEMC0sns5S1yr6swBHlvZy3aF5VJVtfTEAv9xaFUU4EeKormMXDQwz1KYsC4F1c4tIzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754232; c=relaxed/simple;
	bh=Cm5jOGAbLPgkIIetWvZPW/wffySPwqETtTkxCyCtD2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6F+wtnvEt+E/3njHyXYrt4YEfYCU/oatBWP1idDyEqtJbSJWAYxDzBbuPNcOu3Cv56c0D77KQbnSjGJJakR34r+hjoLWmpVSmF2IRArtynROmY1a8SYSjYKgt3hXrM8KJXab3ksjnJdPY5e8fHUvXrxl+hNCJoyTfd5pNvV3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BreIVhzb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BreIVhzb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae3f822163so30805ad.0
        for <linux-modules@vger.kernel.org>; Thu, 05 Mar 2026 15:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772754231; x=1773359031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3hRJWJtgL46YRm7sWrwCb//3MFQJHKTxijQfZVoH+0=;
        b=BreIVhzb8kMd67nJeSBDcqd16rVYlrOBCRU6iCpPo+xE3echh0HKY8412HVrCYD2Sg
         2p5UMTkIUBJtCXIlL0+hosqZX6X3U9W1N5b+D3JBCATsZMPe4UDi7Tbh1VOJYvlE3fWS
         rnoO5l0Yx24424QGM/2lsI4fjBC3SkPqLRCntByiy2ZtflakdppZJTe6XVB8nYCGJ7fk
         ys2HflZYdEMQ7U65hm30gKezzq2IBUZWoOqsRFcZN96nqKlpxw968W+FPZN5l9oOInl/
         dwHjQN+wnVegWGjWu4bnifX/51Jv6pM3YOo2hQ1pbOBEGBtOAtAJQoBqB6UEgk/crSVI
         x/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772754231; x=1773359031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3hRJWJtgL46YRm7sWrwCb//3MFQJHKTxijQfZVoH+0=;
        b=mA8tw5F/e2siUDTdY1ghPOVdMvRVDVus3i+WVAejH8WWYgied8cCUSjJynFvup0LNG
         dwd2rrkSU9eJT4NkdMwcVH+tdy5nUqXvDR1GdtKrQabpW5Vmyf52v5/iS8ttCkAv6FyK
         AbhHAeqiHWV8Cv3LBhCR3smTCzTSaQlukluZlF3Mn2SoU5Dbq3D7LdHvCdmMDWxp3QtI
         I/qUAxORDQO7v3s5mVhHXccsff19FbQOiqwxzR7JQmeLDrLE+ksE2LiG+d7uxq0U+c3p
         9cBUC7COFUkD96t2Fg/sCGP81FgE+uMKRF+P8DF74u2vOM5HuGpVcEjszhUnjCuFchtw
         o4PA==
X-Forwarded-Encrypted: i=1; AJvYcCUSJGS+kt5lXTUuVljkv30czS/GHU7nCTofYj3u/qY7qLE9rXDPEjh+uhH1cERjyznebtAMXt6wuDCdG3kl@vger.kernel.org
X-Gm-Message-State: AOJu0YwlYm/gnnr7dabZU54r3CHGX4K+W/EM+RcjQV6E+WgpElFoTbiA
	DVsfPQfebGH7kciIoOAw1b3tzlYMhqPRSFu3CZQKqMWnCq/+Rq2LyPzNG9UFm50Miw==
X-Gm-Gg: ATEYQzzBNKpXSEklSrxrYqml/XI+rX77sNBUDVYWKoCSNPr3uFaSrJ7doEWog2pfc+1
	zdzL/aNWUqskav4cl9ofqUEeo1k/TXPkGzA2FzHKQIH7689FLP/9JfnBYHObJsH8K40i3ayjHXP
	NDxlzpeuadP7DcV+Apz206NrSu6q9WpnAchMiXjngbpHzlgGzzW0LiA25mteL13eFazXNHIKGg0
	O3+AeEmAazK/e2/le6uw19PwM7w/XbT1Fl81m+P1/iOS7NPwmCXPRuzQ5s40TDDcZIsiePbtrBc
	ZVHxQJ6EV/E95Vbcve1jasosXMWrkmqHbCQfS74s5nYxMGm1Agyf7/y6XVLcd0nBZOTCxq1sbgD
	ezSdDl4y9UaPV3ctpMSgSLTyIcB3fnn81PobVW9ZQYlY9iBIFmFA0TKiaRki6CMDAUCQUqhST5D
	wsgkQtzVlO3SgjvOxjXsLe0abc/kImw6r0G+JIxg4Wlc4cz/8dysloHqa+CASJxRyUyajh+TlWa
	zwvsA==
X-Received: by 2002:a17:902:e845:b0:2aa:d604:62f3 with SMTP id d9443c01a7336-2ae810ebc73mr1327235ad.10.1772754230161;
        Thu, 05 Mar 2026 15:43:50 -0800 (PST)
Received: from google.com (197.23.125.34.bc.googleusercontent.com. [34.125.23.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4dc6dsm22769012b3a.6.2026.03.05.15.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 15:43:49 -0800 (PST)
Date: Thu, 5 Mar 2026 23:43:44 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	atomlin@atomlin.com, linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] module: print version for external modules in
 print_modules()
Message-ID: <20260305234344.GA788042@google.com>
References: <20251231094004.37851-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231094004.37851-1-laoar.shao@gmail.com>

On Wed, Dec 31, 2025 at 05:40:04PM +0800, Yafang Shao wrote:
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3901,7 +3901,11 @@ void print_modules(void)
>  	list_for_each_entry_rcu(mod, &modules, list) {
>  		if (mod->state == MODULE_STATE_UNFORMED)
>  			continue;
> -		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
> +		pr_cont(" %s", mod->name);
> +		/* Only append version for out-of-tree modules */
> +		if (mod->version && test_bit(TAINT_OOT_MODULE, &mod->taints))
> +			pr_cont("-%s", mod->version);
> +		pr_cont("%s", module_flags(mod, buf, true));

On second thought, is using mod->version here safe? We release the
memory for mod->version in:

  free_module
    -> mod_sysfs_teardown
    -> module_remove_modinfo_attrs
    -> attr->free = free_modinfo_version

And this happens before the module is removed from the
list. Couldn't there be a race condition where we read a non-NULL
mod->version here, but the buffer is being concurrently released
by another core that's unloading the module, resulting in a
use-after-free in the pr_cont call?

In order to do this safely, we should presumably drop the attr->free
call from module_remove_modinfo_attrs and release the attributes
only after the synchronize_rcu call in free_module (there's already
free_modinfo we can use), so mod->version is valid for the entire
time the module is on the list.

Thoughts?

Sami

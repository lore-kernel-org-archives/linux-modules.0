Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF738F83
	for <linux-modules@vger.kernel.org>; Tue,  2 Jul 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927963; cv=none; b=iBDeaQloHNPsUbBCJ7C6GptUIxIjycqUuLidemsxWFFCSxPfwb2xnCEgJxfXidTjH03JcpYk2d6dMSai6FMllLzNAvADpMFhGnL76+38I2LJEK1H8kzHXNRATFfpiGuI2u2G+ZxEOkS3dcu1TkJmFo/0OKroDfHOSE22aRUAg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927963; c=relaxed/simple;
	bh=VGdyH+yFJZICp/mwbvFetq0ibB2CUajUHzE5kfWvTEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgCbLJPEi4qOsDcm7iFDPi7cJt2aRpxd7F04P/vMfdKUBxDx9yNjxszyswsaa75zOii5Tu+vFvkUgjzR7rP7OPO2Rdq3vSA3zs0vY2uYdtSOsqA3cu3XqZFXwqjygAHJnxMcVT+5x0fGsG6raqX1hr5CqviFCrdj8aQyZ2idoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WPzHcDfW; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPzHcDfW"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25c9786835eso2475445fac.3
        for <linux-modules@vger.kernel.org>; Tue, 02 Jul 2024 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719927960; x=1720532760; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NiyhmXpZS1r7WZeDrgRFtefnzEGTGZ2jJsCR0mdYOhA=;
        b=WPzHcDfWcap/uSpa3W+MXnbwL2A7RkXNp2gKyn2KGjkbjv/CTyaa4kec4b9RCEVsiA
         UwGhLQnzVTwd3uKoTU5inbWDY1cf7AMz8j8A8qia02i8SqYYOPdoo1EtAuf1Q0dA1AUy
         l6titFLHPsgEbyoiNOiQC11oeJbf+uNmcRSjkTbv45rkQmCzL+MSyVEo+UIjuKuRnWtx
         GyvQk/O6OqeqHp6xT0f/LbA7D5HCWBR9otOWtTkLVlBFkLsjg2dWV5WC07mOmovoiJyR
         lIYb2rTAhepu3EelekSAkdG5h39dUagzpy+XWJNSgixhZXOK1FU7VXWtXlQ1OR6Qnisa
         7z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719927960; x=1720532760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiyhmXpZS1r7WZeDrgRFtefnzEGTGZ2jJsCR0mdYOhA=;
        b=Nhn/C2KPiMgLsBF6JO9up1WCh5fNvTPwIFWQ+lEkTWCY2s1v/rXKy5/bK1XSPS+dYU
         nh9zQgkxVSDtWGUVRCVWBK3fZHKEH6ala6NTBKs9prXeJ0ONI9zjGZC09D2ephdxaCzf
         KaPrhgAltA7vOgG2NFLGLst/BnoybRqGCQav0NQhl3odkRANQw7W3BU4E9ePMqRPX9rj
         ZqbDGAUyFCquTffl7NjBL/Gt4UNiXY4Zw2uZWfWJ8FTz8wQpfXG08blLtJuz4pR8KNQa
         D/MjsxR7vbd6ayerJRePSepi3mlXQmhsRJHwZYYWSOYslTDC+tnrfd69fIeVLhFCNfJj
         W8dw==
X-Forwarded-Encrypted: i=1; AJvYcCVFr8mHVLM7Tsl1RqLjCHMC2b+rIuUz+dFhuquByAPudNIWSxOccvk6YNlLUptPvjkSV6mhFs96FONQJx67oHs/dYYXwfdpv1kdEEs3oQ==
X-Gm-Message-State: AOJu0YwmzH3w6l3MBh0BoXNV8xsweE0Vhjpft8xSwzLZZpr7gx6N6kq3
	GeF2QAfezVDijibmIWASXQjydXV5xq3mM1K/uP4DfQLB4eaCvVev3lwZdWuxCXk=
X-Google-Smtp-Source: AGHT+IFpG/+NxuDQTZzifvzctc9H1OWBvWlhgyHr9DRMBTOjzX5KQcOawMFkjTy2lBWhf7Nw/PdOiQ==
X-Received: by 2002:a05:6870:6494:b0:24f:ebcd:6aa9 with SMTP id 586e51a60fabf-25db338f930mr7423045fac.1.1719927960594;
        Tue, 02 Jul 2024 06:46:00 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:a6f1:b7be:4c8c:bf62])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e1f0490sm2227612fac.20.2024.07.02.06.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:45:59 -0700 (PDT)
Date: Tue, 2 Jul 2024 15:45:55 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?=C1gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	=?iso-8859-1?Q?=C1gatha?= Isabelle Chris Moreira Guedes <patch-reply@agatha.dev>,
	Jookia <contact@jookia.org>
Subject: Re: [PATCH] staging: Fix missing warning/taint on builtin code
Message-ID: <ad745b51-0aef-4a16-95a4-3514846e6504@suswa.mountain>
References: <yf3ewok3u7fu7f4yqlcovcvedkhyjtibvwzlgbcjwf7ijcsktt@vrk54srlnk2n>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yf3ewok3u7fu7f4yqlcovcvedkhyjtibvwzlgbcjwf7ijcsktt@vrk54srlnk2n>

On Tue, Jul 02, 2024 at 02:44:31AM -0300, Ágatha Isabelle Chris Moreira Guedes wrote:
> diff --git a/init/main.c b/init/main.c
> index 206acdde51f5..fca889f3bcc0 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1602,3 +1602,23 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	integrity_load_keys();
>  }
> +
> +#ifdef CONFIG_STAGING
> +/**
> + * staging_init_taint() - We need to taint the kernel whenever staging code
> + * is initialized (from built-in drivers) or loaded (as modules) and issue
> + * a warning the first time it happens.
> + */
> +void staging_taint(const char *code_id, bool module)
> +{
> +	char *code_type = module ? "module" : "builtin driver at";
> +
> +	pr_warn("%s %s: The kernel contains code from staging directory"

Needs a space after directory before the quote.

> +		"the quality is unknown, you have been warned.\n",
> +		code_type, code_id);
> +
> +	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> +}
> +EXPORT_SYMBOL(staging_taint);

regards,
dan carpenter

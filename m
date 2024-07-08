Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE1140363
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453285; cv=none; b=HyoQlVCf40vk2ZxyBnLIZjH8kAmTssokB8AEyDgdIdIVq8mmblZhUIFtCognZf/8wNtxx4fiMqp3wTiccu51lvtunSCFfSwFYkB+9S1rWOUZT1cnhy2XEHXbjrtmmA5Y2Ga14YksU9Wtl2WhFRo5UtItk5sBjUQhMiJqJDNPKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453285; c=relaxed/simple;
	bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wkli+WD001DNqpIl5VgTGI42hd6mgw01Q4uQU5eDbjET+9s8Ft9aWZhn068MfGIiaZD8lGG/lmHzK3XEsB45XpWhWfBEkY6oTL+YIiUj80+DvQr6staP7pdKNDeWkUSkWaKFH7lYsjbyfpULIvYmqqS+PMA+S0hLdpMBCUUQu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I6THk+Uf; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6THk+Uf"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d921528d92so1096313b6e.3
        for <linux-modules@vger.kernel.org>; Mon, 08 Jul 2024 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720453284; x=1721058084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
        b=I6THk+Ufxa7oPGUpTwf25paKUBL/GcJ6sRYE480kVLl98UABU6FlLsCfabp3KC/4rc
         kWwXlPPyzqiDDVedwk/hJ+ZgdvSocmZEaccUEtvdEd2GXo9JjhrQCLQ6u7XdmB4MqXOG
         VBNxpVry7lAKQcf+9sBKJqkNVOSe0L6jbB96Jz9r/dvS8pLHH5NOZ8omkexEy+YQqgPE
         7SodmH1mQXB3ZisLRFGdH2saZZxSYBxSSYyZt1HzCVIGPvtfEutcYDOWnYeMlUmHXszM
         DD2g61wJWzdjQtcJ73R5qd/icCNRaKHFazC1u0Z1Nwr0winO0s0Q8xjLo4ed1daD7Oyo
         RtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720453284; x=1721058084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
        b=sT7lLRNLjJwXZoYAo9iSN0EcOBkFXaL9S5/Z+GOAV7hhUoFRTaZye/OU1MzpT723zz
         4nyzRtJ9MGK6J4x6xmAESX2wjZ2bDgG2QBPU0Yqj1fQotstCGt7Sz1w7su8xlr+Pde6o
         QUXli/0dd25Nuy7YBhBMs9HOtru1b4BUDEd/i1Yv4txdrUXviFJNb3VRDKAeHW9pKvpz
         dqgSwIGnleH8tKFs+MqbaRP8IR0W1rll6bX2VqvDtCU/Xd4fXsEYVPoB1q+OV2oypg19
         o1XMoNW9+cKSaJDLWeXwYpTUsE4VGyBLQpwLmdTv8yyMIF7eqJTig+SZ3dW15ebePnql
         seqA==
X-Forwarded-Encrypted: i=1; AJvYcCW4HPJD900e6ygtYpPHS46QFkUf92JCXMgeUMEe0WZkhNPtBxOim7dBFGw2Zm/XOBcq30tjFSH2lTztpkGlzRPiqZ/chBUXExaVEG66SA==
X-Gm-Message-State: AOJu0YxTbsBJ34C+b8XYMcgaifgshfnNou+cEM7gJ+6PzOgvWkOw6/Ga
	ih8KqmunAFXT1qI1EJBMun0GlOk6tfreaEIUvUUkPHR/npPyfCmHq/E6PibofkE=
X-Google-Smtp-Source: AGHT+IE4fartsbVqJ1ZXTAUJYr3DKVogSxSpB+ivKX+k3fcl6RoAaf2u7l1kY5INfh9HbLRD0moHGg==
X-Received: by 2002:a05:6808:13c7:b0:3d5:633b:3d8d with SMTP id 5614622812f47-3d914ea41fbmr11853349b6e.53.1720453283519;
        Mon, 08 Jul 2024 08:41:23 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6fc:b7f5:4853:aff3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93ad2b3e5sm28150b6e.29.2024.07.08.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:41:23 -0700 (PDT)
Date: Mon, 8 Jul 2024 17:41:21 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?=C1gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	patch-reply@agatha.dev
Subject: Re: [PATCH v3] init: staging: Fix missing warning/taint on builtin
 code
Message-ID: <11f00921-e8d5-488f-82e5-a22e68fc5748@suswa.mountain>
References: <zsk54zosv6tht4j4nma4ix7lq2knxi3ylqadd2foznc72nkaa3@xbc7gpozx6ai>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zsk54zosv6tht4j4nma4ix7lq2knxi3ylqadd2foznc72nkaa3@xbc7gpozx6ai>

Thanks!

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


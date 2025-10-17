Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0B332EA3
	for <linux-modules@vger.kernel.org>; Fri, 17 Oct 2025 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702768; cv=none; b=HWb7GgWs6Nbai/33WT/orRvWtwN3ACIdNAtfjQCzYBKItG1eGf1JOGPcJ1dibxPj4JJtUu6d2VKF5tjnWdiqm0QXhXL/RSWopDcNmEJzfTU45EuTNDb5ai0i5VLU6hL9kJ9AqugAT+h4us0hPheLQAsujRb2tOj6F79WNkT98pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702768; c=relaxed/simple;
	bh=+NgMevCRO6L5hXhJaaqAwueyAJujC7V7TL40Xm8q1k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=P6aweeMmEj8f5d7/5KlaXiLy+QQwW6OwZqEuInZYNkdvpirru1ls4q8Mf6gTGHlSsniCpbRNOeGz3jjdpYFHoO4Jyk3FmlOOuPtauUKMeJjm2qFneca1wqmWdsNhp14fzjQmYj21O6jMSwhdyGEFw/6YaHMej5BgjTux02kFqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fqnk4XHt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fqnk4XHt"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso16113425e9.0
        for <linux-modules@vger.kernel.org>; Fri, 17 Oct 2025 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760702765; x=1761307565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMJOXnoCYtJ81aWFXZNVAXjz4V/A/3LlOZhUuqnJKQw=;
        b=Fqnk4XHt0Jh8dbaATrWbwwB0fCERbcjPoxZy9iLPmC+nH9PLpP2XBinYA3vtAAfLHF
         taz05ifTkug5bXHCJwHPgBEtg/PfG7xcMRgUMKnQd6PAa9to+7jT2AzW1Cff1rAvXmmK
         W704HX0Pof3v/op/toy78Jrkxhdlu8toJ2DrHhJK4eOcbHgT/UfaU1HeTVJFYuPavPni
         1CEsIEl+ZM4hbkPrTTi2ejrFbVcgCHsB/0izQ20yDwbBL9t8KBRD7i5blgLfuoltF6uQ
         Il/XVjSk418McwOotZ4E+GhRZnVUJ1ewsYnNtLtL0LwXWxNpjev7u7k+nIkQ7u69Qcf8
         XnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760702765; x=1761307565;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMJOXnoCYtJ81aWFXZNVAXjz4V/A/3LlOZhUuqnJKQw=;
        b=lMt1igaqHidKnFE5pHwnKuO4hIod1Sy2A3ipu1XLNrqXc6L7GpeYbrz8/heyvNsYEl
         7FQmW0a5upC0+y1ppYsfnnzReDq6dALdPQsoHdsBgcZS+2BXMK9eSTdm/xB2xmWgKRQG
         H5mco0LonkfbM6EPWipb2/bjPhPmt3RQ5TJ8wtUDPb5f3hIjc13WxpNU8y6TnTN7zIOz
         SnZj1CWgpxnD1eKRlEmT9Br6s+vr7Oq6mI1LNFhUKTWe7NUsldzG/965caN+4Nl1GFSr
         9/0ZXeFuDZVnLpr2vwmZaVxYIIScZNPskgOvnC6NDZdSqsOTeEr/DbviBJcK9qhOQMGE
         jk2A==
X-Gm-Message-State: AOJu0Yz54CTQa0dA1GmwR2DJ/IGf8UPAPxbOZAVA1ZkMZPpMrI+m3WTQ
	X+GOUhWM5sOtmLTCSWF0ViIU6p4mitcL0L3GRPGTmnIBwIk8j6wcSuOoAKbmxaLGlDnd1lBRII8
	n5P55
X-Gm-Gg: ASbGncvBGuNBDbGBVyGK7zL/FUmgZ9GQD1Dbnb2FgU39pylbvbGA3MyWUEuQkK+zvYT
	cVZT/aXObVuWkn+OaaQCHo0OeI3QuImRJi41AGwds4LLx7aVrzFvYu66myDdx4bD6TDewEgbsk0
	N5P8ZQJzcO0aD2ZGzLd/UcsX75L3M+JU1zEMfQnEIiENc1dfessbshy3yjr58YPXy57GOl0GM2E
	cnY8PLRRCu4PSNLAp/ixeX62rcClnQrLidFS4wOUbn9Q36DzvguUcui7bmId2p5G5V0XfqOIXcU
	IR1dhdr25dft5bgaoAzyVDfrt2UwZ2PIucp9ZAm5M3TjcOlL8mRkC89l6fjwLEVTDTEY0g8jF1+
	USmy9mqcvAFXI6AaeO2f1mKls7fKBJeL5/XKpMfmKBiBaf4aM7Tkr+vXAPKJGGTaeK2ba5vY55b
	wbRTaHoqwG0wCN48GkOTYy
X-Google-Smtp-Source: AGHT+IFRqPYZeqMdMjuOp1opwrAil9k3VDnWPeVIrTRqMOXEXLvF1v38xSucSH6cagYDSWL467ybBA==
X-Received: by 2002:a05:600c:4eca:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-4711786c6f0mr28564785e9.7.1760702764657;
        Fri, 17 Oct 2025 05:06:04 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm107319845e9.3.2025.10.17.05.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 05:06:04 -0700 (PDT)
Message-ID: <e0b031d6-2b2d-4788-ac9c-b76e6a4bfab0@suse.com>
Date: Fri, 17 Oct 2025 14:06:03 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] module: Simplify warning on positive returns from
 module_init()
To: Lucas De Marchi <lucas.demarchi@intel.com>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
 <20251013-module-warn-ret-v1-2-ab65b41af01f@intel.com>
Content-Language: en-US
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251013-module-warn-ret-v1-2-ab65b41af01f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 6:26 PM, Lucas De Marchi wrote:
> It should now be rare to trigger this warning - it doesn't need to be so
> verbose. Make it follow the usual style in the module loading code.
> 
> For the same reason, drop the dump_stack().
> 
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

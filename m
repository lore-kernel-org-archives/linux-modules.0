Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65FA2A
	for <linux-modules@vger.kernel.org>; Mon, 25 Sep 2023 01:36:39 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF2AEE
	for <linux-modules@vger.kernel.org>; Sun, 24 Sep 2023 18:36:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso38080775ad.1
        for <linux-modules@vger.kernel.org>; Sun, 24 Sep 2023 18:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695605797; x=1696210597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qeR5XrVQCInkFvx4VClyLg8dKxcBVpTRgwbskRCliSE=;
        b=G943H23MYQ6LXiY0kjYoGISQ003X57VSvAfDkG6KJ/iI0Fdew7u/SXx5CINHeGhkZP
         imI3UaP+sHq/KJcMAdnPQw9s0nLrI+U9IpQKiy7RcNXVwYfpoAqzvUzLynA7Lkr/23+f
         s/YhfLm/wvd4U6a/RH73TyJVPuEfd9W6M72Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695605797; x=1696210597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeR5XrVQCInkFvx4VClyLg8dKxcBVpTRgwbskRCliSE=;
        b=q+Oexv6Lu8wTr70IV0dCw4P2jJCCt1qOQUBtTnSIqPlsbrVcXo1MMrnFJz5CWPNgNb
         D9FE8T231vyyKldbhA4j7NbhNHxvgnwJGWyU6bFoAQCFHtureJ+oSsSj4kYuFIgEokA0
         oq8ik5Q6BMbjkweklK0uE4RlRcTFm+SDQP6R7qY4tGXm+ldcpL0WG9DCpctvtnl53hlt
         t/HIVL7GOF9oNxgSJjyJAl0vDwYiW3mux6HT9fAugktdoh76Q7fp6k0yG3Ncx/eWj50P
         mVlZCravYu0TP0vA4Vq76QEB40jOz028i0oQwZJKAT6jOQpUV87t5AH8APCtRt6jb5cK
         O3cw==
X-Gm-Message-State: AOJu0YwN6J75UNeB2TU7bgpYb04rZ6jKDPxs8+Ai/ApRPJX3Ap1Dp8+e
	ejjFGQxKDLT14PQUL2P8SmgHpuGkU73tPw/wc4U=
X-Google-Smtp-Source: AGHT+IFgP8xAPt84G1p21QIiajeTaaTzy7k0n+4+919AGIdahFuIEHSLkgXwzzsCd+zrFF4P/7jCvw==
X-Received: by 2002:a17:903:187:b0:1c3:3347:996e with SMTP id z7-20020a170903018700b001c33347996emr4573484plg.23.1695605797563;
        Sun, 24 Sep 2023 18:36:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jk13-20020a170903330d00b001b9da8b4eb7sm2045534plb.35.2023.09.24.18.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 18:36:36 -0700 (PDT)
Date: Sun, 24 Sep 2023 18:36:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add include/linux/module*.h to modules
Message-ID: <202309241836.22B5359@keescook>
References: <20230920211009.1009150-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920211009.1009150-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 02:10:09PM -0700, Luis Chamberlain wrote:
> Use glob include/linux/module*.h to capture all module changes.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

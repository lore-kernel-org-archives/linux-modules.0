Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F701A591
	for <linux-modules@vger.kernel.org>; Wed, 20 Sep 2023 17:18:22 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15E1AF
	for <linux-modules@vger.kernel.org>; Wed, 20 Sep 2023 10:18:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76f2843260bso464374785a.3
        for <linux-modules@vger.kernel.org>; Wed, 20 Sep 2023 10:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695230299; x=1695835099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvRASRZ30aa4ckLY9Z2xrkhqCfpBOZbqUseHqMRS5nM=;
        b=TLv9Vssbajgh3Qym4NBpYYccdOWWpDHQjyPmNBTGQibAe3OqZUlDOEV5xFNsNx1y68
         vse89lZZJsIZYqAxKVKHRNpz1wveijSpaRH/2F1bxactiM56nL7Y1gy1/gUlbBCLpAWP
         t2iS9a6ffVRrk5EdwLEU5NYWYfDIr8f90HMY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230299; x=1695835099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvRASRZ30aa4ckLY9Z2xrkhqCfpBOZbqUseHqMRS5nM=;
        b=bbZhBKT49YnC2rto5W0VUEo8tQERsvbogvRPRzlUquvOcf4bXUH3xFk/ziVNps2UlT
         Gkw05PgGiS7/+pCRugzxF4460w8mgNSe9ZMsDMDWQXuC+Qiunot3aKDZ2LlrDIcJjU0T
         jvI2lIgRDLPX9Ivg/N2XbmTwNEioJZ/cW+UL7FVOTF40QrJnQRg3PmdhuoWWlhKgtICk
         MwuR+AJrUkslG8tTplhbrd4N7v3OC5lOtKxQWq0JRqiIf2/7MUh1il4dExJURRhbL7Kq
         25EiENnX6DKmHNfxM3dMDDuTkL6DyfPaNkKPTcVgybtZxf6EAvwvawvtn1gApItKRnEB
         OoHg==
X-Gm-Message-State: AOJu0YwdnLcqyoCa6vgSyjANF/zngibHGljLMycR7l3ge6EwcZLTF9ch
	C+LxDgqT2UoeOAMPRm7YzY+BiUGE0mwCIpaxGZc=
X-Google-Smtp-Source: AGHT+IH0lI54lRkck2xGhoHAT7LTn7Nglkmm9+eLuRdZbpHZeijWo7hW03iZzWG7G+KlCrPRkTNZEQ==
X-Received: by 2002:a05:620a:4d2:b0:76c:da53:f1c3 with SMTP id 18-20020a05620a04d200b0076cda53f1c3mr2999369qks.41.1695230299704;
        Wed, 20 Sep 2023 10:18:19 -0700 (PDT)
Received: from meerkat.local ([209.226.106.110])
        by smtp.gmail.com with ESMTPSA id t29-20020a05620a035d00b0076f058f5834sm4963368qkm.61.2023.09.20.10.18.19
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:18:19 -0700 (PDT)
Date: Wed, 20 Sep 2023 13:18:10 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-modules@vger.kernel.org
Subject: Re: This list is being migrated to the new infrastructure
Message-ID: <20230920-unviable-antonym-a94a1e@meerkat>
References: <20230920-mural-oblivious-e8d0ae@meerkat>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920-mural-oblivious-e8d0ae@meerkat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 12:58:23PM -0400, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> This list is being migrated to the new vger infrastructure. This should be a
> fully transparent process and you don't need to change anything about how you
> participate with the list or how you receive mail.
> 
> There will be a brief 20-minute delay with archives on lore.kernel.org. I will
> follow up once the archive migration has been completed.

This work is now completed. I will monitor the performance to make
sure that the new infrastructure is still successfully coping with the
email traffic.

If you notice any problems, please report them to helpdesk at kernel.org.

-K

Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126AAC7EE24
	for <linux-modules@archiver.kernel.org>; Tue,  6 Jun 2023 18:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbjFFSZZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 6 Jun 2023 14:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbjFFSZJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 6 Jun 2023 14:25:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE0B199A
        for <linux-modules@vger.kernel.org>; Tue,  6 Jun 2023 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fG+EfrUAleP/6YnV1a9CLisaUcrUHfDyFWWCYEZXf18=; b=IFTszi3VOKfhF4OKB7lgQnhtRj
        2Rh2znbxiQwCPSLlww16ERaVbw+kumbFr835UNuypj4s0nPs2fmyx7Xy4HL0iSJoXMRANh5ADoK45
        PHhRcvOy5v7TrSKb1LQogDRJjTAFmLq+lD4sHS1MaGfUHDno4lRo3rWlX7fInHQzg75tv1GGNsHQ1
        IM6MXXReWivAfhovsHHMHL4LRJQRVoplhKhwYyCzo5fbNZ5ay8X/BZ3zDCiEGI9Q3pSDE1REn4pe5
        lBjMMc8FObZilE+jd9VwLOGODtXjffYe5/CXBz54mHVnBWXE2hKuWAO+YrGdUXKWva8cCJUwQooqQ
        ZTMDlTiQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6bLv-002l7K-1n;
        Tue, 06 Jun 2023 18:24:19 +0000
Date:   Tue, 6 Jun 2023 11:24:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/5] libkmod: Do not inititialize file->memory on open
Message-ID: <ZH950x7YoKajEj9V@bombadil.infradead.org>
References: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
 <20230601224001.23397-2-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601224001.23397-2-lucas.de.marchi@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 01, 2023 at 03:39:57PM -0700, Lucas De Marchi wrote:
> diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
> index b6a8cc9..1449c41 100644
> --- a/libkmod/libkmod-file.c
> +++ b/libkmod/libkmod-file.c
> @@ -421,6 +421,7 @@ struct kmod_elf *kmod_file_get_elf(struct kmod_file *file)
>  	if (file->elf)
>  		return file->elf;
>  
> +	kmod_file_load_contents(file);
>  	file->elf = kmod_elf_new(file->memory, file->size);
>  	return file->elf;
>  }

<-- snip -->

> @@ -491,6 +492,14 @@ error:
>  	return file;
>  }
>  
> +int kmod_file_load_contents(struct kmod_file *file)
> +{
> +	if (file->memory)
> +		return 0;
> +
> +	return file->ops->load(file);
> +}

Should be void if we are not really going to be using the return
value when we use this routine?

  Luis

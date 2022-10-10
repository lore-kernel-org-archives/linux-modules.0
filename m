Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F94C433FE
	for <linux-modules@archiver.kernel.org>; Mon, 10 Oct 2022 22:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJJWi0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJJWiZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 10 Oct 2022 18:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E233343B
        for <linux-modules@vger.kernel.org>; Mon, 10 Oct 2022 15:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665441502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P5viJ+Zb2p3oW579v/fCAvnP1g7/ho/FXg6uX+38eS8=;
        b=fdxDfUoj6jMVYFVzQqzKVE/FZjYZplg6jY0bgiJ+vJAkQzU1IWvLs9rJZyecdum73vn6u1
        QMtb8rF2oc8veGouiJdEbVEvZzwrEhjgmqyosRmFebGT5OvCe5TF3+ypGYL3WN8/a9cp1k
        yOV4Q93oM3J0uw6pE0Fy6kKA0PH03Tw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-s9L62IhjMGq1TeDENBtohA-1; Mon, 10 Oct 2022 18:38:21 -0400
X-MC-Unique: s9L62IhjMGq1TeDENBtohA-1
Received: by mail-wm1-f69.google.com with SMTP id c130-20020a1c3588000000b003b56be513e1so7630572wma.0
        for <linux-modules@vger.kernel.org>; Mon, 10 Oct 2022 15:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5viJ+Zb2p3oW579v/fCAvnP1g7/ho/FXg6uX+38eS8=;
        b=iOELKWrqS10em2PKb74SycRaw0eL6KORZVZmOjAZz6ckGiZU/vMyXUk4E5Ny8vYnfU
         R3EqrIULMjHYp7uvx5rfMym/k6r6wNXdFqVpRzN1J/TA1eCmtV4sigSOQbZbulMtAO0b
         Tow2g6VoqGGgaVZdB4WRvwykJnpFoD0qaRc8oiZ9+ZYDoqhtQd18i9F1MFNtMy7CW3ri
         9K7BBjt1LRo9e7ODRDxL//lFQGwlQRdl3ZvVe4M5hNbRG+aKLGul0c2bQn3t7mcFiYfQ
         /CL5pQ9jqJSR37JkdBU6Ua3YqfS5mAWhuUzbMngIGL8MGooAxDvIY0hZjz/SHsgi2YtX
         E8gw==
X-Gm-Message-State: ACrzQf2p91JF9033wgtCBJLBKi4ws8BhW/QoM14HHvi150laAIvspUR+
        JrcgdA335//MrAFWvdwLM8B0D45DnZOW9xtAGI4tG1zP8/QG+tpAATURuG5N5n0K6WTzMILl/pY
        deJyQMArsAhK4SHk/gOcmJ5LR
X-Received: by 2002:a7b:cd15:0:b0:3c5:1b4c:7632 with SMTP id f21-20020a7bcd15000000b003c51b4c7632mr8793550wmj.2.1665441499671;
        Mon, 10 Oct 2022 15:38:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5kw7kGqQ8TH8BdTKOf5QU6caDHMMwMUH/VIdiykzpENMGGS+Uk4+J39hrb/ITUTgwCbMp11g==
X-Received: by 2002:a7b:cd15:0:b0:3c5:1b4c:7632 with SMTP id f21-20020a7bcd15000000b003c51b4c7632mr8793543wmj.2.1665441499435;
        Mon, 10 Oct 2022 15:38:19 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id z1-20020a7bc7c1000000b003b435c41103sm21295448wmk.0.2022.10.10.15.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 15:38:18 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:38:17 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Unloaded tainted modules list with tcrypt
Message-ID: <20221010223817.cw6gccru2k35ksn5@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2022-10-10 15:12 +0000, Elliott, Robert (Servers) wrote:
> When repeatedly using the tcrypt module (which is designed to never
> load successfully), the "Unloaded tainted modules" list grows forever:
> 
> Unloaded tainted modules: tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 padlock_aes():1 padlock_aes():1 
> isst_if_mbox_msr():1 acpi_cpufreq():1 pcc_cpufreq():1 isst_if_mbox_msr():1 
> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
> pcc_cpufreq():1 isst_if_mbox_msr():1 acpi_cpufreq():1 acpi_cpufreq():1 
> pcc_cpufreq():1 isst_if_mbox_msr():1 acpi_cpufreq():1 acpi_cpufreq():1 
> isst_if_mbox_msr():1 isst_if_mbox_msr():1 
> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 isst_if_mbox_msr():1
> 
> Some other modules like acpi_cpufreq() are repeated too.
> 
> Maybe this check after the name comparison:
> 	mod_taint->taints & mod->taints
> should be:
> 	mod_taint->taints == mod->taints
> 
> or shouldn't be there at all?
> 

Elliott,

Actually, see Linus' tree i.e. commit 47cc75aa9283 ("module: tracking: Keep
a record of tainted unloaded modules only").


Kind regards,

-- 
Aaron Tomlin


Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB71FC11F64
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jul 2021 17:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1A8613DD
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jul 2021 17:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGASBu (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:01:50 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40257 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229844AbhGASBu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jul 2021 14:01:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DDC15C0108;
        Thu,  1 Jul 2021 13:59:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 01 Jul 2021 13:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=gbhupmDyckGTsG1bzUCzQngwkdV
        D+LraT5VaPoA6pRU=; b=t9TUUnbjzfze7PRro2I8auCEsNdMFNrfoCmAHZE0S4I
        gaMOEhK3oc6UUEyhDf5MQekQBmhC8yxQxZ17g2c2UPOA/QYIlDGkhNy8DnvBYswu
        ou+t5d9ePlQBCvpgrVjCapbzVxFfi+wI+kKtQnG3cSUIBBauyRUCrFwf8l+bda2O
        IzMLmN2Y0bRuFj+7PNpRxqTSyQK8qXl/P8XL9qcj99hEQnoCyqKpWilKy3HBbG79
        Bz7GbnSZdwcf+hccU/MCCCf10d3XLRL1HXiFwY9vsJJiM+ec2Y75Vz8CoyKkU9ax
        pS64Ra+5r+QmaCJLyWLzR5E+7AK44EjPHzNaOL3XXaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=gbhupm
        DyckGTsG1bzUCzQngwkdVD+LraT5VaPoA6pRU=; b=TqwldebBV0hquywOrH75mW
        KEYz2ac1oH9cfZz8rfkEDIgJ35TRdGzon+8bUGXB4GLcy/Djt15nfuo5GmaaRxxS
        VOxhDI+XlMD0xldcGoCMhIlJ+ICJ+CBn1wFU4xkogrkNOrH0Y/+6j9pUyieUl9HT
        e6qPXsRY6ekpQ2q0ZeHWpiNtb37/tMpIyCX4VJtEESmdcQJ39XCrhXaOO+zrv8ba
        hVBP2Al94kUvwOt3pFc0aK+8U3r0IRGYZBPDy+QNwMNMRl9T0ijWJXyuShRN5ke8
        u5lF1luh5SO3ZcqjxJnudWsVo94nMfUJ6yfVSd/RlxFZtPt6TtdbKUu6FEzbw6lw
        ==
X-ME-Sender: <xms:dwLeYHXFjOSg0LFwoB5vGcf-KbXO5wh5O_0bfIfQ7P6NkiEBirUKdg>
    <xme:dwLeYPlMKY_Adu1QZ-C0yCW_EeUVQp-FWILPHaJ-GgYLYtao7jYbaX8uFV7JC0RwE
    dF7ZRM_gfmVtA>
X-ME-Received: <xmr:dwLeYDbUqepfPa9AkkaV4GPYt7agiCNaUvlnBbpIBf4LkJjhphsOIXcz0eu_YY_H_4c0u_jl2f9Igy48GYEN-feFod9EN-3h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeiiedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpefgteefffetvdffledtgeduudetffdutdduveefvedtue
    egueeggfeiteehfeetfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:dwLeYCVLozmHIth9oZVGwSFLD9lozK0BGL29707z7JlzwyPo0aTCug>
    <xmx:dwLeYBkBatiNn4uN1ADTiVsuKKphSpaLwIzcTQPomUUqKt7Pt6HtfQ>
    <xmx:dwLeYPeJEZRAIVLfAgjpk_SwiG3GBkC0_rTlcHHOeJwi0seRs-TINA>
    <xmx:dwLeYKDtv_pS4iRyR82qrRv5336ckLPlv3iAbL_hyMiAx22SpEPjaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jul 2021 13:59:17 -0400 (EDT)
Date:   Thu, 1 Jul 2021 19:59:13 +0200
From:   Greg KH <greg@kroah.com>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     linux-modules@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: Seeking advice on "monkey patching" a driver
Message-ID: <YN4Ccf96sqMoPJM3@kroah.com>
References: <30faa352-0f60-10b9-887e-b2ee522d0a16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30faa352-0f60-10b9-887e-b2ee522d0a16@gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jul 01, 2021 at 11:25:49AM -0500, Ian Pilcher wrote:
> I maintain a couple of out-of-tree modules that enable "mainstream"
> distributions to be used on the Thecus N5550 NAS.
> 
>  https://github.com/ipilcher/n5550/tree/master/modules
> 
> The disk activity LEDs in this NAS are software controlled, so the
> n5550_ahci_leds module exists to "inject" a wrapper around libahci's
> qc_issue() function which triggers the correct LED (if any).
> 
> 
> https://github.com/ipilcher/n5550/blob/25538096fffd7942be8b7f2c66af580620a422b6/modules/n5550_ahci_leds.c#L225
> 
> It's certainly a hack, but it makes use of the modules much simpler, as
> there's no need to patch and rebuild libahci, override the distro-
> provided module, etc.  As long as modprobe is configured to load
> n5550_ahci_leds immediately after libahci and before any consumers of
> libahci are loaded, things "just work".
> 
> The current version of n5550_ahci_leds attempts to ensure that no
> libahci consumers are loaded before it modifies libahci's
> ahci_ops.qc_issue.  It does this by:
> 
>   * locking module_mutex
>   * getting a reference to the libahci module (with find_module())
>   * checking libahci's reference count
>   * grabbing a reference to *itself* to prevent itself from being
>     unloaded
>   * modifying ahci_ops.qc_issue
>   * unlocking module_mutex

Oh that's horrible, please no, do not do that :)

> (There similar logic in the n5550_ahci_leds_enabled_store function to
> reverse the modifications, if no other libahci consumers are loaded.)
> 
> It's very possible that some or all of these precautions are
> unnecessary (or that they're inadequate).  I am most definitely not an
> expert at kernel development or the details of the kernel's module
> loading mechanism.  I and few others have, however, been successfully
> using these modules for a number of years.
> 
> I've just discovered that neither module_mutex nor find_module() are
> available in recent kernels, and I'm unsure how to proceed.  The two
> options that I've been able to think of thus far are:
> 
> * YOLO!  I can simply remove the checks from the module and rely on user
>   space to ensure that n5550_ahci_leds is loaded before any libahci
>   consumers load (i.e. before udevd starts).
> 
> * kprobes - I have a feeling that this is the "correct" way to do this
>   (and it would have the benefit of working even if libahci or its
>   consumers aren't built as modules).  OTOH, it isn't clear how I would
>   go about accessing the arguments passed into the function without
>   JProbes, and I'm not thrilled with the idea of adding additional
>   overhead and/or locking to the disk I/O path.

How about a third option, the correct one:
	- submit your code changes upstream and they get merged into the
	  main kernel tree and no monkeypatching is ever needed at all!

Have you submitted your changes upstream to the existing drivers?  What
is preventing that from happening today?

thanks,

greg k-h

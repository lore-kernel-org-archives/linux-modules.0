Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14412C76188
	for <linux-modules@archiver.kernel.org>; Mon,  3 Apr 2023 21:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjDCVKp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 3 Apr 2023 17:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjDCVKm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 3 Apr 2023 17:10:42 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4897C19AC
        for <linux-modules@vger.kernel.org>; Mon,  3 Apr 2023 14:10:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id cj15so22267811qtb.5
        for <linux-modules@vger.kernel.org>; Mon, 03 Apr 2023 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680556236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEedN3bFTKzplQihfI4j8rnbysKd1Yj2PDXKX4P7kwM=;
        b=h7rvXuVkFrIWxst6mbUhJE+VbY1rJ8L65pGKWRq8GoSZpg2yrgLOLQCv55XgjMt9TR
         Ypq+O4BolZT5cd6jNbBstEdaWNZjiT/a+I1TOruXvCFDPwu7kjqbcGvbYTVadTnlxPqc
         63NeASk/DV37iGvmjBLnIIaYXIvy6lKhUgQhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680556236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEedN3bFTKzplQihfI4j8rnbysKd1Yj2PDXKX4P7kwM=;
        b=W8fyj3Nw1Uybr9rHYwz++i6SmZmX7iDP0f/nAcc+BT5kug6V5GvB60iHNAKczvkEJc
         KPQ90gHPBBic1NTR6SMhaQdwp+8AChe3BLSG+qU8j0HGUaednEbfLgw0SUKpLXz+tSoj
         RUd6pJp7fnw/swDgrV1zxZc9XvQO8EjAzOReOreUrelgLWP3eDcIQRodGqrs48YvEMTj
         BPBZsF79yeeTGwyo+0E7a7EETSRsRHoATSZpz/DEzKhsY8sEOJ3rQsigvE3WEfZJnjnF
         Z0yIOiAYiJ9+712orwBKN4cEd9w5x+cAB3TUoM19T/Ab5U2bbhUyN5yo7wy8zOhg5BFz
         3jPQ==
X-Gm-Message-State: AAQBX9fpmBgrfxt9neVdOL8PBb/5gQIjz1ZuRq75s4JZWroM/5DNGWCf
        yxDXH8smUVN+J4jQ0BGOtOBmsQ==
X-Google-Smtp-Source: AKy350Y6NdhYwxVrVxkuUuzyHSSC6NmaiEYhkuwzo+WXtqbGB8fRbMVe6dS7atcWdSTUYrUZ8bolmA==
X-Received: by 2002:ac8:7d81:0:b0:3e6:469b:85df with SMTP id c1-20020ac87d81000000b003e6469b85dfmr16802971qtd.18.1680556236394;
        Mon, 03 Apr 2023 14:10:36 -0700 (PDT)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id r9-20020ae9d609000000b0074a29c9d8b7sm2301008qkk.134.2023.04.03.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:10:35 -0700 (PDT)
Date:   Mon, 3 Apr 2023 17:10:33 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     jim.cromie@gmail.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, song@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with
 module_memory")
Message-ID: <owkyirqlrkdwvlmd4vlivgahd5uycolsdii3kvwbvakj5222mh@nydsfzk7uqtz>
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 30, 2023 at 04:45:43PM -0600, jim.cromie@gmail.com wrote:
> hi Luis, etal
> 
> kmemleak is reporting 19 leaks during boot

Hi, all:

I'm going to use this thread to test out bugbot. You can just ignore it and
let it do its thing behind the scenes -- if it explodes, I'll take care of it.

It should just send a single follow-up telling us that it's tracking the
thread, but otherwise stay entirely out of everyone's hair.

bugbot on

Sorry for interrupting and thank you for your patience -- this is for a good
cause, I promise. :)

-K

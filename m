Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2473BC433E0
	for <linux-modules@archiver.kernel.org>; Mon, 11 Jan 2021 14:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E200E22472
	for <linux-modules@archiver.kernel.org>; Mon, 11 Jan 2021 14:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbhAKN7u (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 11 Jan 2021 08:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbhAKNGd (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 11 Jan 2021 08:06:33 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBE0C061786
        for <linux-modules@vger.kernel.org>; Mon, 11 Jan 2021 05:05:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a12so37629477lfl.6
        for <linux-modules@vger.kernel.org>; Mon, 11 Jan 2021 05:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gh3LAHVoZ13tNSNxyl48BscJHu7DmAGOA8k6UgBmg5k=;
        b=g2MbSpaBZ1XozhX8y6fGzYeProuebeoSxR1WWPv0AXTsxQ4eIQDqvTah8qK6Iceq6L
         Paz4vHwOCPt2l8dZgROHT/JNkUsS3TjQNoXHGi/Vtlw15bgzaDoKZzvdC9Yat2tnwJOg
         F1H+PsXFOdKdgMLibw9MPq0jHaM6roRQHwAYzzRE5newHv0+BK8I/0oFxdu7iZsSxIHS
         nAYsqnNIKwKdhXoFd9jADL/rWH2fi9ZNJSJWha9rSXPGqf1HQMWY6HfJkXrH/8W8ZAHL
         l11W+yCz6u5rY0CcvF+NVR/KV8ibFYdQGsNg/s0k9J2YmqdhfzJj90e2lhdP99meGxcS
         GqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gh3LAHVoZ13tNSNxyl48BscJHu7DmAGOA8k6UgBmg5k=;
        b=fmHMf2tLjUNyMhR7o80Dgb2arY48//oqg7QVIiRTjOohgWwwOLhLC1niVfTU/Z9tXb
         2huBKrICdFpVPo/AMALfDbT+wjqgAwXK+E7V0tvKmCAKiEYOe4WqZ0wFyhDOrm1Jnym8
         mfwPtzkYb2cSjZhR83kYVXImT+vT/7C2EqEG8LIpK0a9Aa4ag6asTkTQIwjXme38KVc0
         ic84N0xY9rwE2+Pq3RLXeUmyz5pC4Oo6Jo4bMyfToswLPmW2Mtrelvh55xuKtT2NN97B
         JrkSBpCPW0in22DgvzJXj4as7b8f8wUIMbH9Y0OxSiAKzKy0nqxUNaQ2CtF/tTMMXLop
         0eKw==
X-Gm-Message-State: AOAM532TovjiBvlEYxRN6uBRJjuLg7li7Ys09mZJWNecKiV/krXoMJA8
        TZ+sz2zYoXQjpGqgFw3SYVMNqgjQTQn0j+vOPsU=
X-Google-Smtp-Source: ABdhPJwzFe3y8lDD9XtneMJBzvl5qehOIYFtT5UvWArz1mSqb7LRyAUuNFSY2jQa8d2Gw3E00AtOj2ch0aquVM+Uea4=
X-Received: by 2002:ac2:50c1:: with SMTP id h1mr7689638lfm.350.1610370351120;
 Mon, 11 Jan 2021 05:05:51 -0800 (PST)
MIME-Version: 1.0
References: <X/e48mOg7WfVxRc0@bongo.bofh.it> <CAKi4VA+RA8Sr85dHrRf9-XL5cJ8_rf=0WG68zQQQO6JA4qRPjw@mail.gmail.com>
 <X/fcBfwqlw1XkE/H@bongo.bofh.it>
In-Reply-To: <X/fcBfwqlw1XkE/H@bongo.bofh.it>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 11 Jan 2021 05:05:38 -0800
Message-ID: <CAKi4VA+5n2nLGm2j9RjYwaAybqOcC_vu0hpCNzB_62QVeGz13w@mail.gmail.com>
Subject: Re: Bug#970871: "modinfo -F" always shows name for built-ins
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jan 7, 2021 at 8:14 PM Marco d'Itri <md@linux.it> wrote:
>
> On Jan 08, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
>
> > On Thu, Jan 7, 2021 at 5:55 PM Marco d'Itri <md@linux.it> wrote:
> > >
> > > The attached patch fixes this.
> >
> > who is the author?
> I am.

applied, thanks.

Lucas De Marchi

>
> --
> ciao,
> Marco

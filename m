Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB5BC10F1E
	for <linux-modules@archiver.kernel.org>; Tue, 20 Dec 2022 17:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLTRcc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 20 Dec 2022 12:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiLTRc0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 20 Dec 2022 12:32:26 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56771A39E
        for <linux-modules@vger.kernel.org>; Tue, 20 Dec 2022 09:32:24 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id 97so3032103uam.0
        for <linux-modules@vger.kernel.org>; Tue, 20 Dec 2022 09:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UAJ6ozZf1vu2YYAWt3gFC9VQjMPZpc1AMSbQVjo7i1o=;
        b=gqNpcDSXd9iWJlYUJaZWTXX3W+vCHukpVRLhAaqrlQ+19MKELs0kkmqcKLzUonANkU
         ieOS9elD7sGFkMh/CKr9xRNK8TZDV36VRXUSe7S8xh3oJYV0pcw4/l5jy6fM2gTMm8jZ
         TblIKBFxsChHQFo7eDzhsjYEFW5FPCKDbaOrtTCMNT1ODtFI/ZsITFsdlMOO6A+H82o6
         AoyO1KzZc/5NxGkGXLW+Q4P2s/M4JBl282hLQsiG+6YW57zaXc3Ht32XiKn9m6mtX+T9
         IIeazx9Q1vrZxXM+QXZxIfV63ig1aQNLhX1nOI3pVIMaxONugcAyeDsrQ5qhgoSbbJiH
         Zikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAJ6ozZf1vu2YYAWt3gFC9VQjMPZpc1AMSbQVjo7i1o=;
        b=jCxveGxAYJQ0oFz2eTK1etmuBp5V+X/H8kdQkNGZusUsHhJXWTmxqGa1N6hp1tVyBW
         13HKxVDCu8mGDQPKVWJeE4PwGWF9CLLcivnQ9CaTkj395MGO2pkz01O78k6PBGDCxudp
         07VGUWG8JCcWI5AFzJoqyN5B4lVGjlItK55Ab0dlgxcxYjnZe+UEESzmvgbUhKa3qx4y
         ykJop7rmsIMUnhr10mOQUo3INdc8T/RtBLqQWPYFxyypGGJ8pvnJCyW7XBW1Rhp1TUmQ
         pSMJqZzvNPzqKRKArne21PWT9wlNX4xWV2ZR+sfZ2rGTKUaHGQDB1ftm544K661ZBQIe
         KhPQ==
X-Gm-Message-State: ANoB5pk0kTeOaGlo5BVhhZEiuOW22LxyYYClgY7NlIWMHi/yyBnUxEi5
        Vo4DDN+rcrouoxJj752tvx3LpV2eS+xRWkU8PEC5DhF5Y2avgRqBjcg=
X-Google-Smtp-Source: AA0mqf5kqYpjjbeudDgMyNOjausfNjbZmWzkWJCBlhwfP1+5mUAvDokT6sGoWku9veOqPqbeJIqGoG2CUdnsG7kWaW4=
X-Received: by 2002:ab0:1054:0:b0:418:f8ed:3313 with SMTP id
 g20-20020ab01054000000b00418f8ed3313mr42866251uab.0.1671557543767; Tue, 20
 Dec 2022 09:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com> <20221219204619.2205248-8-allenwebb@google.com>
 <Y6FZniRwpogJ0HaG@kroah.com>
In-Reply-To: <Y6FZniRwpogJ0HaG@kroah.com>
From:   Allen Webb <allenwebb@google.com>
Date:   Tue, 20 Dec 2022 11:32:12 -0600
Message-ID: <CAJzde05B0Ag1e7Lpbg5hKK+2SYj0JYLKLkMQNoag3MBXKWUd6g@mail.gmail.com>
Subject: Re: [PATCH v9 07/10] modpost: Add -b option for emitting built-in aliases
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Dec 20, 2022 at 12:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 19, 2022 at 02:46:15PM -0600, Allen Webb wrote:
> > This adds an unimplemented command line flag for writing the built-in
> > aliases to a file.
>
> If it is unimplemented, why add it?

This is a fairly self contained change even though the code that
populates mod->modalias_buf is in the next patch. I could flatten the
two commits, but I was trying to keep this to a single logical change.
There is somewhat of a chicken and egg problem here. If the other
patch comes first it will be dead code, if this comes first it is
pretty much dead code.

>
> And this needs a lot more description as to why you are changing this
> here, as well as documentation for the flag you added, right?

I might be missing something, but I don't see an obvious place where
the other command line parameters for modpost are documented, so I
will add a comment inside the case statement unless you have a better
idea.

>
> thanks,
>
> greg k-h

Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A4BC433F5
	for <linux-modules@archiver.kernel.org>; Thu, 17 Feb 2022 19:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245210AbiBQTeC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 17 Feb 2022 14:34:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245213AbiBQTeB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 17 Feb 2022 14:34:01 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDD615D389
        for <linux-modules@vger.kernel.org>; Thu, 17 Feb 2022 11:33:46 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f37so1170257lfv.8
        for <linux-modules@vger.kernel.org>; Thu, 17 Feb 2022 11:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/oXewggFOpjaRjDxmMp91h85U911KTGRKHlUJsGGsQ=;
        b=FLYJj+HDXnNK+2/4k1WZ2enZbSNYyOZHY5fHdZ6/uCEhjkTyF6AePplpqyVtXKiacB
         fn8KWnnuFV6Vcr6GX7B0JqPRswxiPTZdc9jlevxWgNX3OoVMFimiSx9dFnoXmHAOGLKY
         T8CZDUUO8aw/RcZNk3m7HhNmK+LErsoJQsLG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/oXewggFOpjaRjDxmMp91h85U911KTGRKHlUJsGGsQ=;
        b=wmveiNn5NZi9O04hF/4NATw+1HzdVk6yy4aANWF+Px4CrxvN641vXZ90OzqjOjw+ll
         XqNlSuoyva2FxnYJs7/Xw7j8swpH1uK4+vzBV57v7kl6a8tpij8/v6xu4EEXd2k5PJWG
         zuk0SZuND56w7Ay6yVZSRrPX+0rH2kAPOglTegYs4IvmZpJPgxRcV2BvJIjNP5xe7JrP
         ZdE8mhb3Bjm0cf9xplHIaxSzoEnfKqg6HMCCaxGh9E/rHDxs/iieshZauv4l78WGXZXb
         ue9Zn/M9A08giJR4POcvUNiqwul3Ob/fhoSGeunZcUkMaZ/Wr7mLZ5IC6SBeS0KObrcd
         d/cA==
X-Gm-Message-State: AOAM5309JgTOAbJPVcmKm+tOOysRcqlpTNr+lIrBeeXPDEVEuljCj66R
        EKvI7rZvuOHJ8t28hqqTQZzC4p/pqdRx2Pny
X-Google-Smtp-Source: ABdhPJwASDiYtyhkTUEa2uweiUnP3PH753YZgeGVZq1DWjnG1etYEFRZEJOwKQgPBEwhktNhxVJDzA==
X-Received: by 2002:a05:6512:ad1:b0:443:9227:a6d8 with SMTP id n17-20020a0565120ad100b004439227a6d8mr3140219lfu.235.1645126424596;
        Thu, 17 Feb 2022 11:33:44 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id h18sm61599ljq.133.2022.02.17.11.33.39
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 11:33:40 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id f37so1169833lfv.8
        for <linux-modules@vger.kernel.org>; Thu, 17 Feb 2022 11:33:39 -0800 (PST)
X-Received: by 2002:ac2:4d91:0:b0:443:127b:558a with SMTP id
 g17-20020ac24d91000000b00443127b558amr3044488lfe.542.1645126419579; Thu, 17
 Feb 2022 11:33:39 -0800 (PST)
MIME-Version: 1.0
References: <Yg2C2NTphV3eMkUp@bombadil.infradead.org>
In-Reply-To: <Yg2C2NTphV3eMkUp@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Feb 2022 11:33:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjR67HKkrPkmHXYET5M0EVwtrfAFC+AvZPd4obpzvXLLw@mail.gmail.com>
Message-ID: <CAHk-=wjR67HKkrPkmHXYET5M0EVwtrfAFC+AvZPd4obpzvXLLw@mail.gmail.com>
Subject: Re: Modules fixes for v5.17-rc5
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        patches@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, Aaron Tomlin <atomlin@redhat.com>,
        Vimal Agrawal <avimalin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 16, 2022 at 3:03 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> So far only one fix has trickled through for modules. It is part of this
> pull request. It's a minor build fix for when CONFIG_SYSFS=n. Let me
> know if there are any issues with this.

The only issue I have is that because you didn't put "[GIT PULL]" in
the subject line, the pr-tracker-bot doesn't pick up on it, so you're
not getting a "this has been merged" confirmation email.

My own search criteria for pull requests aren't as strict, so I saw it
in my pending queue. But then I spent time wondering why I didn't see
the pr-tracker-bot response when I pushed out, so I actually prefer
for people to use the stricter rules that the pr-tracker-bot looks
at...

                  Linus

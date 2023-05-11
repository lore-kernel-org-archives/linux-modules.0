Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D984C77B7C
	for <linux-modules@archiver.kernel.org>; Thu, 11 May 2023 15:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbjEKPZI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 11 May 2023 11:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbjEKPZH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 11 May 2023 11:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC728126
        for <linux-modules@vger.kernel.org>; Thu, 11 May 2023 08:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A13264EEF
        for <linux-modules@vger.kernel.org>; Thu, 11 May 2023 15:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF074C433EF
        for <linux-modules@vger.kernel.org>; Thu, 11 May 2023 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683818705;
        bh=4Sm0KDitLDD3f/sHoAOACfsJJn/LEWKAOyenQCmPYiw=;
        h=From:Date:Subject:To:Cc:From;
        b=bSUggfnBvzLDypA/nMSnFzjnld3PnyDw5FrMBKrGi+JkBxbTSGRste0sO+yXwi4mB
         gu+odkixkO6DTwjirTNoDCk0lHXD4lUiUprqz1hLeIEDFGYl3kFkcu1CfJKnmtLUwq
         malhKf5pzj+7qBaJ2699R+ipxxcpN8Mn6oodUSFbW9rqq+3NhsIPI2mgf85WmFNa2l
         0o3aKBoS3dYFM5zfQ/q72/BDrKbFBulIUruws7yAlzWZPQqPVWFuGFKrCv0hKlw3PN
         HF2LqqTPDrQJ6eAK6bSbPLEJpyvlefSpuEttALPZ7IcjQf6qvUDapJp44e/zJ5NNqC
         Dl8WCWa90ulVw==
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-44fa6454576so3119689e0c.0
        for <linux-modules@vger.kernel.org>; Thu, 11 May 2023 08:25:05 -0700 (PDT)
X-Gm-Message-State: AC+VfDygPTn0ySV8GJJkYqt6tQNVz3cosz2Ii9MSnGnUYUtbWrIhCyNI
        i9CF81L1JTHTZp5+AdIlrhRZsOIHxql2w3le9a0=
X-Google-Smtp-Source: ACHHUZ7Y+YmzmN4919uk8egJOsW3pwC7xJxEJw8G7nkEzoEk/1Lh60O1v1HAv0VcztzQA3+3Aifie/Q3NyxHkKwzeBw=
X-Received: by 2002:a1f:3f96:0:b0:440:3793:6ab2 with SMTP id
 m144-20020a1f3f96000000b0044037936ab2mr7036573vka.13.1683818704851; Thu, 11
 May 2023 08:25:04 -0700 (PDT)
MIME-Version: 1.0
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Thu, 11 May 2023 08:24:53 -0700
X-Gmail-Original-Message-ID: <CAB=NE6VKXO+GnGR8e5m35SGmqM+vRw7YKqty3r-b0_Pyhhg5iA@mail.gmail.com>
Message-ID: <CAB=NE6VKXO+GnGR8e5m35SGmqM+vRw7YKqty3r-b0_Pyhhg5iA@mail.gmail.com>
Subject: Taking on patchwork for linux-modules
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Song Liu <song@kernel.org>,
        Konstantin Ryabitsev <mricon@kernel.org>,
        linux-modules@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Lucas, Konstantin,

I'd like to relive the linux-modules patchwork. It seems to be active
but I'd like to start using it and making tweaks for it for artifact
testing so to enable automation of testing for patches posted and so
forth. How can I claim it ?

Motivation behind this is to enable automation of testing with kdevops
for Linux modules both for the sefftests and then also the userspace
kmod tools. Then eventually I want to work with Song on performance
metrics to keep track of future changes as in the future we expect to
get patches which may alter performance aspects of Linux due to this.

This will all allow us to review proactively the effects / breakage of
patches posted. My hope is that if we're successful we can document
this to leverage similar strategies to help maintenance of other
complex subsystems which require more complex testing.

  Luis

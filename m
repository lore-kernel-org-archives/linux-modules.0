Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B1C636D6
	for <linux-modules@archiver.kernel.org>; Fri, 17 Feb 2023 22:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBQWnm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 17 Feb 2023 17:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjBQWnl (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 17 Feb 2023 17:43:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C822CFD1;
        Fri, 17 Feb 2023 14:43:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7485A62085;
        Fri, 17 Feb 2023 22:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FF8C433D2;
        Fri, 17 Feb 2023 22:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676673818;
        bh=+HbER9gRaOdqJvCgoiw4p+5mwFXigj7PGX4lXXJ384A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Rk4XhBugAiTkQspoJtCST31JGdnpEMV/5G/pgFpc7prYn7hknhEHya2H8cKDesZeJ
         ShVYF42a7Xv9+pEFwP/CItzwNH5DbrNjehqI93K9SItPcFpPc85XR1j6qJk0XlMhMB
         UMNVWhxXyTYiIw3gqtipuY4w/U/GW/xdi47AlxVZ7Ltc0YsH/dhvYt6XGemgTQZshv
         30/iLWmJGDg9tHzqc7LxODLOI7Jo93rrLjXkkLevTmugVdzspEilDD9YUqx9mxeL4C
         9RYQb38l+2STOfqugN0jo5PkkrBwip/PoDBrolQXNS4+xG0x+6A3dvS/9LoizLpTOY
         EUb6A1F0hMqkw==
Message-ID: <1c249c45ef3ac3c4904e0f5a3da11637.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230217141059.392471-14-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com> <20230217141059.392471-14-nick.alcock@oracle.com>
Subject: Re: [PATCH 13/24] kbuild, clk: bm1880: remove MODULE_LICENSE in non-modules
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Date:   Fri, 17 Feb 2023 14:43:36 -0800
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Quoting Nick Alcock (2023-02-17 06:10:48)
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>=20
> So remove it in the files in this commit, none of which can be built as
> modules.
>=20
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-clk@vger.kernel.org
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

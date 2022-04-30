Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE87C433EF
	for <linux-modules@archiver.kernel.org>; Sat, 30 Apr 2022 20:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244859AbiD3UI1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 30 Apr 2022 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiD3UI0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 30 Apr 2022 16:08:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B769CD2;
        Sat, 30 Apr 2022 13:05:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14356610A0;
        Sat, 30 Apr 2022 20:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5679DC385AF;
        Sat, 30 Apr 2022 20:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651349102;
        bh=oUajYsbpmQfPjauhUlSGdVX7VzyspcKJr2s+l1nrudw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1ulnpTymTZDZfj5yFVo7TIw+otQXaNKTaCTvt/2Qpklru/qcMAWqJWJBQx4xE4ks
         ivQk/FSCZSJlSRAg+0nNHnr7FNR2/u3MK2+Ipk7I8eaSuR/9RVTFMhlUNS4Dx+TG1f
         oVxpLNcz/El89G3Qrt0eqsMI99GHePjm9tcUK/QNlT1EEEnEs/lhoHd1rGo3wcZune
         u77lrK6PY45iV+9gNEWBx49ZlGxWWIjYf1kSMGmDhnTs3qtYh81xzqGltbZ/Nx0mMc
         aWWYV4ayq6cXjAz0PGn4sh9pKH+qsw2Sdz15vLEyPdpzJANkUxley1HlbZcQ8qKhJr
         vUE7FC6f+m4Kg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nktKr-001uvx-O0; Sat, 30 Apr 2022 21:04:57 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Kai Vehmanen" <kai.vehmanen@intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@intel.com>,
        "Takashi Iwai" <tiwai@suse.com>, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        mauro.chehab@linux.intel.com
Subject: [PATCH v5 2/2] ALSA: hda - identify when audio is provided by a video driver
Date:   Sat, 30 Apr 2022 21:04:55 +0100
Message-Id: <4a0f0e351941201d00b2cd8e2157d3b0181dc19e.1651348913.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651348913.git.mchehab@kernel.org>
References: <cover.1651348913.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On some devices, the hda driver needs to hook into a video driver,
in order to be able to properly access the audio hardware and/or
the power management function.

That's the case of several snd_hda_intel devices that depends on
i915 driver.

Ensure that a proper reference between the snd-hda driver needing
such binding is shown at /proc/modules, in order to allow userspace
to know about such binding.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v5 0/2] at: https://lore.kernel.org/all/cover.1651348913.git.mchehab@kernel.org/

 sound/hda/hdac_component.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
index bb37e7e0bd79..7789873ddf47 100644
--- a/sound/hda/hdac_component.c
+++ b/sound/hda/hdac_component.c
@@ -199,7 +199,7 @@ static int hdac_component_master_bind(struct device *dev)
 	}
 
 	/* pin the module to avoid dynamic unbinding, but only if given */
-	if (!try_module_get(acomp->ops->owner)) {
+	if (!try_module_get_owner(acomp->ops->owner, dev->driver->owner)) {
 		ret = -ENODEV;
 		goto out_unbind;
 	}
-- 
2.35.1


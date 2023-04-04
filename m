Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9955C6FD1D
	for <linux-modules@archiver.kernel.org>; Tue,  4 Apr 2023 11:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjDDLEh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 4 Apr 2023 07:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjDDLEY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 4 Apr 2023 07:04:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A7604C00;
        Tue,  4 Apr 2023 04:02:04 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8Dxldh2AyxkVGUWAA--.39556S3;
        Tue, 04 Apr 2023 19:01:10 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx+711Ayxk_SwVAA--.19499S3;
        Tue, 04 Apr 2023 19:01:09 +0800 (CST)
To:     yangtiezhu@loongson.cn
References: <1680254153-14582-4-git-send-email-yangtiezhu@loongson.cn>
Subject: Re: [PATCH 3/3] module: Ignore L0 and rename is_arm_mapping_symbol()
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, mcgrof@kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <16869b48-28f0-28e4-bafb-cb1fa7f69660@loongson.cn>
Date:   Tue, 4 Apr 2023 19:01:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1680254153-14582-4-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cx+711Ayxk_SwVAA--.19499S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUgq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK0I
        I2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0
        Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84
        ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc80
        4VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY2
        0_WwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0zRVWlkUUUUU=
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

LGTM.

Tested-by: Youling Tang <tangyouling@loongson.cn> # for LoongArch


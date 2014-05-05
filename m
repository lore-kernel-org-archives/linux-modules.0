MIME-Version: 1.0
In-Reply-To: <CAJs94EbQS62ASfY0ZTOmUa8Y_1_jkSVHdMMLw9B5yyhm_pLbZg@mail.gmail.com>
References: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com>
	<CAKi4VALtbKS=wj1KncN+kt+5hRPLDYxzkuDDg-3Cm+wr2mK5JQ@mail.gmail.com>
	<CANkykrBdJ-u-OWWgBZj_Jsghd8oqhC6AtRK7dvs=EGFt7EozMQ@mail.gmail.com>
	<CAJs94EZbVaS=N0xpAQbAySBzX_e6JR1o8FJkrJ0f4buCWvsZSA@mail.gmail.com>
	<20140502141357.GA24741@politreco>
	<87a9axc82r.fsf@rustcorp.com.au>
	<CAKi4VAL4+nErBqO+z-LJCYxuMqEHmsv0272ju6xQQ2W9ra3+wg@mail.gmail.com>
	<87ppjsbkmi.fsf@rustcorp.com.au>
	<CAJs94EbQS62ASfY0ZTOmUa8Y_1_jkSVHdMMLw9B5yyhm_pLbZg@mail.gmail.com>
Date: Mon, 5 May 2014 09:44:54 -0300
Message-ID: <CAKi4VA+B2jfhu8Me5zYheQL_4FN7=vPTguHLjAtfE9JfNs2GSg@mail.gmail.com>
Subject: Re: [PATCH] Fix recursion loop in mod_count_all_dependencies()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Gustavo Sverzut Barbieri <barbieri@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, May 5, 2014 at 7:16 AM, Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:
> 2014-05-05 14:11 GMT+04:00 Rusty Russell <rusty@rustcorp.com.au>:
>>  A provides symbol S1.
>>  B provides symbol S1, needs S2.
>
> I think this should be reported too. This case is the most probably a
> bug in the kernel or/and in its configuration. Can depmod detect two
> modules providing the same symbol?

Currently it doesn't because the kernel modpost already warned about
it. However it's very easy to add. Just replacing hash_add() with
hash_add_unique() while adding the symbol and treating the return
would do the job.

Lucas De Marchi

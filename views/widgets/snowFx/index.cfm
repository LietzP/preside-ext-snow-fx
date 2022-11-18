<!--- Let it Snow! --->
<cfoutput>

	<!--- Settings --->
	<cfset duration = args.duration/>
	<cfset color = "###args.color#"/>
	<cfset amount = args.amount/>
	<cfset blowDistance = 400/>

	<!--- Code --->
	<style>
		/* customizable snowflake styling */
		.snowflake {
			color: #color#;
			font-size: 1em;
			font-family: Arial;
			text-shadow: 0 0 1px ##fff;
		}
	
		@-webkit-keyframes snowflakes-fall {
			0% {
				top: -5%;
				opacity: 100%;
				}

			80% {
				opacity: 0%;
			}
	
			100% {
				top: 105%;
				opacity: 0%;
				}
			}

	
		@keyframes snowflakes-fall {
			0% { 
				top: -5%;
				opacity: 100%;				
				}

			80% {
				opacity: 0%;
			}
			
			100% {
				top: 105%;
				opacity: 0%;				
				}
			}
	
		@-webkit-keyframes snowflakes-shake {
			0% {
				-webkit-transform:translateX(0px);
				transform:translateX(0px)
				}
				
			50% {
				-webkit-transform:translateX(80px);
				transform:translateX(80px)
				}
				
			100% {
				-webkit-transform:translateX(0px);
				transform:translateX(0px)
				}
			}
		
		@keyframes snowflakes-shake {
			0% {
				transform:translateX(0px)
				}
				
			50% {
				transform:translateX(80px)
				}
				
			100% { 
				transform:translateX(0px)
				}
			}

		@keyframes snowflakes-blow {
			0% {
				transform:translateX(0px)
				}
				
			95% {
				transform:translateX(#blowDistance#px)
				}
				
			100% { 
				transform:translateX(0px)
				}
			}

		@-webkit-keyframes snowflakes-blow {
			0% {
				-webkit-transform:translateX(0px);
				transform:translateX(0px)
				}
				
			95% {
				-webkit-transform:translateX(#blowDistance#px);
				transform:translateX(#blowDistance#px)
			}

			100% {
				-webkit-transform:translateX(0px);
				transform:translateX(0px)
			}
		}
			
		.snowflake {
			position: fixed;
			top: -5%;
			z-index: -100;

			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
			user-select: none;
			cursor: default;


			-webkit-animation-timing-function: linear, ease-in-out;
			-webkit-animation-iteration-count: infinite, infinite;
			-webkit-animation-play-state: running, running;


			animation-timing-function: linear, ease-in-out;
			animation-iteration-count: infinite, infinite;
			animation-play-state: running, running;
		}

		<cfloop index="i" from="0" to="#amount#">
			.snowflake:nth-of-type(#i#) {
				left: #1 + (i * (100 / amount))#%;
				<cfif args.snowKind == "blow">
					left:  #1 + (i * (80 / amount))#%;
					/* top: #1 + (i * (100 / amount))#%; */
				</cfif>

				<cfset delay = rand() * duration>
				<cfset local_duration = (randRange(100, 200) / 100) * duration>
				<cfset blur_value = randRange(1, 8)>

				<cfif args.useBgEffect == "1" && blur_value lt 2.5>
					z-index: 100;
				</cfif>
				
				filter: blur(#blur_value#px);
				-webkit-filter: blur(#blur_value#px);

				<cfif args.snowKind == "shake">
					animation-name: snowflakes-fall, snowflakes-shake;
					-webkit-animation-name: snowflakes-fall, snowflakes-shake;

					animation-duration: #local_duration#s, #3*randRange(1, 4)#s;			
					-webkit-animation-duration: #local_duration#s, #3*randRange(1, 4)#;

					-webkit-animation-delay: #delay#s, #delay/2#s;
					animation-delay: #delay#s, #delay/2#s;
				<cfelseif args.snowKind == "blow">
					<cfset local_duration = local_duration + delay>
					animation-name: snowflakes-fall, snowflakes-blow;
					-webkit-aniation-name: snowflakes-fall, snowflakes-blow;

					animation-duration: #local_duration#s, #local_duration#s;			
					-webkit-animation-duration: #local_duration#s, #local_duration#s;

					-webkit-animation-delay: #delay#s, #delay#s;
					animation-delay: #delay#s, #delay#s;
				<cfelse>
					animation-name: snowflakes-fall;
					-webkit-aniation-name: snowflakes-fall;

					animation-duration: #local_duration#s;			
					-webkit-animation-duration: #local_duration#s;

					-webkit-animation-delay: #delay#s, #delay/2#s;
					animation-delay: #delay#s, #delay/2#s;
				</cfif>

				transform: rotate(#randRange(0, 360)#deg);
			}
		</cfloop>

	</style>

	<cfset snowflakes = ["❅", "❅", "❆", "❄", "❅", "❆", "❄", "❅", "❆", "❄"]>
	
	<div class="snowflakes" aria-hidden="true">
		<cfloop index="i" from="1" to="#amount#">
			<div class="snowflake">
				#snowflakes[randRange(1, len(snowflakes))]#
			</div>
		</cfloop>
		
	</div>
</cfoutput>
